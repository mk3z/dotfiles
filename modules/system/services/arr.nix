{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.arr;
in {
  options.mkez.services.arr.enable = mkEnableOption "Whether to enable arr stack";
  config = mkIf cfg.enable {
    services = {
      lidarr = {
        enable = true;
        openFirewall = true;
      };
      radarr = {
        enable = true;
        openFirewall = true;
      };
      sonarr = {
        enable = true;
        openFirewall = true;
      };
    };
  };
}
