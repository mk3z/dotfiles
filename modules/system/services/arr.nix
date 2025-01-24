{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.arr;
  inherit (config.mkez.core) hostname;
  inherit (config.services.tailscale) interfaceName;
  inherit (config.mkez.services) cross-seed;
  prowlarrPort = 9696;
in {
  options.mkez.services.arr.enable = mkEnableOption "Whether to enable arr stack";
  config = mkIf cfg.enable {
    nixpkgs.config.permittedInsecurePackages = [
      "aspnetcore-runtime-6.0.36"
      "aspnetcore-runtime-wrapped-6.0.36"
      "dotnet-sdk-6.0.428"
      "dotnet-sdk-wrapped-6.0.428"
    ];

    services = {
      lidarr.enable = true;
      radarr.enable = true;
      sonarr.enable = true;
      prowlarr.enable = true;

      nginx = {
        enable = true;
        virtualHosts."${hostname}.intra.mkez.fi" = {
          locations = {
            "/lidarr".proxyPass = "http://localhost:8686";
            "/radarr".proxyPass = "http://localhost:7878";
            "/sonarr".proxyPass = "http://localhost:8989";
            "/prowlarr".proxyPass = "http://localhost:${toString prowlarrPort}";
          };
        };
      };
    };

    networking.firewall.interfaces = {
      ${interfaceName}.allowedTCPPorts = [80 443];
      "podman0".allowedTCPPorts = mkIf cross-seed.enable [prowlarrPort];
    };

    mkez.virtualisation.podman.enable = true;
    virtualisation.oci-containers = {
      backend = "podman";
      containers.flaresolverr = {
        image = "ghcr.io/flaresolverr/flaresolverr:latest";
        hostname = "flaresolverr";
        ports = ["8191:8191"];
        environment.LOG_LEVEL = "info";
      };
    };
  };
}
