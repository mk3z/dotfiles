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
  nameservers = ["10.64.0.1"];
in {
  options.mkez.services.transmission = {
    enable = mkEnableOption "Whether to enable transmission";
    download-dir = mkOption {
      description = "Completed downloads directory";
      type = types.path;
    };
    incomplete-dir = mkOption {
      description = "Incomplete downloads directory";
      type = types.path;
    };
  };
  config = mkIf cfg.enable {
    mkez.services.mullvad.enable = true;

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

      bindMounts = {
        download-dir = {
          mountPoint = cfg.download-dir;
          hostPath = cfg.download-dir;
          isReadOnly = false;
        };
        incomplete-dir = {
          mountPoint = cfg.incomplete-dir;
          hostPath = cfg.incomplete-dir;
          isReadOnly = false;
        };
      };

      config = {
        services.transmission = {
          enable = true;
          # Enables tweaking of kernel parameters to open many more connections at
          # the same time.
          performanceNetParameters = true;
          downloadDirPermissions = "777";

          settings = {
            inherit (cfg) download-dir incomplete-dir;
            umask = 0;

            rpc-bind-address = localAddress;
            rpc-whitelist = hostAddress;
            rpc-host-whitelist = "${hostname}.intra.mkez.fi,transmission-rpc";

            port-forwarding-enabled = false;
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
          firewall.trustedInterfaces = ["ve-rpc"];
          useHostResolvConf = false;
          # Mullvad DNS server
          inherit nameservers;
        };

        system.stateVersion = "24.05";
      };
    };

    services.nginx.virtualHosts."${hostname}.intra.mkez.fi".locations."/transmission" = {
      proxyPass = "http://${localAddress}:${toString rpc-port}/transmission";
      proxyWebsockets = true;
    };

    networking.firewall.interfaces.${interfaceName}.allowedTCPPorts = [80 443];

    networking = {
      nat = {
        enable = true;
        internalInterfaces = ["ve-transmission"];
        externalInterface = "wg-mullvad";
        enableIPv6 = true;
      };
      extraHosts = "${localAddress} transmission-rpc";
    };
  };
}
