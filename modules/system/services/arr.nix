{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.arr;
  inherit (config.mkez.core) hostname;
  inherit (config.services.tailscale) interfaceName;
in {
  options.mkez.services.arr.enable = mkEnableOption "Whether to enable arr stack";
  config = mkIf cfg.enable {
    services = {
      lidarr.enable = true;
      radarr.enable = true;
      sonarr.enable = true;

      nginx = {
        enable = true;

        recommendedGzipSettings = true;
        recommendedOptimisation = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;

        virtualHosts."${hostname}.intra.mkez.fi" = {
          locations = {
            "/lidarr".proxyPass = "http://localhost:8686";
            "/radarr".proxyPass = "http://localhost:7878";
            "/sonarr".proxyPass = "http://localhost:8989";
          };
        };
      };
    };

    networking.firewall.interfaces.${interfaceName}.allowedTCPPorts = [80 443];
  };
}
