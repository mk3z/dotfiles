{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkOption mkIf types;
  cfg = config.mkez.services.jellyfin;
  inherit (config.mkez.core) hostname lanInterface;
  tailscaleInterface = config.services.tailscale.interfaceName;
  inherit (config.mkez.services.jellyfin) port;
in {
  options.mkez.services.jellyfin = {
    enable = mkEnableOption "Whether to enable Jellyfin";
    port = mkOption {
      description = "Jellyfin web interface port";
      type = types.int;
      default = 8096;
    };
  };
  config = mkIf cfg.enable {
    services = {
      jellyfin = {
        enable = true;
      };

      nginx = {
        enable = true;
        virtualHosts."${hostname}.intra.mkez.fi".locations."/jellyfin".proxyPass = "http://localhost:${toString port}";
      };
    };

    networking.firewall.interfaces = {
      ${lanInterface}.allowedTCPPorts = [port];
      ${tailscaleInterface}.allowedTCPPorts = [80 443 port];
    };
  };
}
