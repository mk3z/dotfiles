{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.jellyfin;
in {
  options.mkez.services.jellyfin.enable = mkEnableOption "Whether to enable Jellyfin";
  config = mkIf cfg.enable {
    services.jellyfin = {
      enable = true;
      openFirewall = true;
    };
  };
}
