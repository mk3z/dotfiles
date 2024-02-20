{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.jellyfin;
  inherit (config.mkez.core) hostname;
  inherit (config.services.tailscale) interfaceName;
in {
  options.mkez.services.jellyfin.enable = mkEnableOption "Whether to enable Jellyfin";
  config = mkIf cfg.enable {
    services = {
      jellyfin = {
        enable = true;
        openFirewall = true;
      };

      nginx = {
        enable = true;

        recommendedGzipSettings = true;
        recommendedOptimisation = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;

        virtualHosts."${hostname}.intra.mkez.fi".locations."/jellyfin".proxyPass = "http://localhost:8096";
      };
    };

    networking.firewall.interfaces.${interfaceName}.allowedTCPPorts = [80 443];
  };
}
