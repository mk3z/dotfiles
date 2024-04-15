{
  lib,
  config,
  ...
}: let
  inherit (lib) types mkOption mkEnableOption mkIf;
  cfg = config.mkez.services.transmission;
  inherit (config.services.tailscale) interfaceName;
  inherit (config.containers.transmission.config.services.transmission.settings) rpc-port;
  inherit (config.containers.transmission.extraVeths.ve-rpc) localAddress hostAddress;
  inherit (config.mkez.core) hostname;
  nameservers = ["9.9.9.9"];
  port = 51413;
in {
  options.mkez.services.transmission = {
    enable = mkEnableOption "Whether to enable transmission";
    downloadDir = mkOption {
      description = "Downloads directory";
      type = types.path;
    };
  };
  config = mkIf cfg.enable {
    networking = {
      nat = {
        enable = true;
        internalInterfaces = ["ve-transmission"];
        externalInterface = "vpn";
        enableIPv6 = true;
        forwardPorts = [
          {
            sourcePort = port;
            destination = "${config.containers.transmission.localAddress}:${port}";
          }
          {
            sourcePort = port;
            destination = "[${config.containers.transmission.localAddress6}]:${port}";
          }
        ];
      };
      extraHosts = "${localAddress} transmission-rpc";
    };

    networking.nftables.tables.natTransmission = {
      family = "inet";
      content = ''
        chain POSTROUTING {
          type nat hook postrouting priority srcnat; policy accept;
          ip daddr ${config.containers.transmission.localAddress} tcp dport ${port} counter masquerade
          ip6 daddr ${config.containers.transmission.localAddress6} tcp dport ${port} counter masquerade
        }
      '';
    };

    services.nginx.virtualHosts."${hostname}.intra.mkez.fi".locations."/transmission" = {
      proxyPass = "http://${localAddress}:${toString rpc-port}/transmission";
      proxyWebsockets = true;
    };

    networking.firewall.interfaces = {
      ${interfaceName}.allowedTCPPorts = [80 443];
      "vpn".allowedTCPPorts = [port];
    };

    containers.transmission = {
      autoStart = true;
      privateNetwork = true;
      hostAddress = "192.168.100.10";
      localAddress = "192.168.100.11";
      hostAddress6 = "fc00::100:1";
      localAddress6 = "fc00::100:2";

      extraVeths.ve-rpc = {
        hostAddress = "192.168.200.10";
        localAddress = "192.168.200.11";
        hostAddress6 = "fc00::200:1";
        localAddress6 = "fc00::200:2";
      };

      bindMounts.downloadDir = {
        mountPoint = cfg.downloadDir;
        hostPath = cfg.downloadDir;
        isReadOnly = false;
      };

      config = {
        services.transmission = {
          enable = true;
          downloadDirPermissions = "777";

          settings = {
            peer-port = port;

            download-dir = "${cfg.downloadDir}/complete";
            incomplete-dir = "${cfg.downloadDir}/incomplete";
            umask = 0;

            rpc-bind-address = localAddress;
            rpc-whitelist = hostAddress;
            rpc-host-whitelist = "${hostname}.intra.mkez.fi,transmission-rpc";

            utp-enabled = false;

            dht-enabled = false;
            lpd-enabled = false;
            pex-enabled = false;

            download-queue-enabled = false;
          };
        };

        # Fix for https://github.com/NixOS/nixpkgs/issues/258793
        systemd.services.transmission.serviceConfig = {
          RootDirectoryStartOnly = lib.mkForce (lib.mkForce false);
          RootDirectory = lib.mkForce (lib.mkForce "");
        };

        networking = {
          firewall = {
            trustedInterfaces = ["ve-rpc"];
            interfaces."eth0".allowedTCPPorts = [port];
          };
          useHostResolvConf = false;
          # Mullvad DNS server
          inherit nameservers;
        };

        system.stateVersion = "24.05";
      };
    };
  };
}
