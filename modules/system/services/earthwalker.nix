{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.earthwalker;
  tailscaleInterface = config.services.tailscale.interfaceName;
  port = 8080;
in {
  options.mkez.services.earthwalker.enable = mkEnableOption "Whether to enable Earthwalker";
  config = mkIf cfg.enable {
    virtualisation.oci-containers.backend = "podman";

    virtualisation.oci-containers.containers.earthwalker = {
      image = "registry.gitlab.com/glatteis/earthwalker";
      autoStart = true;
      ports = ["${toString port}:${toString port}"];
      environment = {
        HOST_UID = "1000";
        HOST_GID = "1000";
        TZ = config.time.timeZone;
      };
    };

    networking.firewall.interfaces.${tailscaleInterface}.allowedTCPPorts = [port];
  };
}
