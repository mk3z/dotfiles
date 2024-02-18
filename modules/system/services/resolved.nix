{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.resolved;
in {
  options.mkez.services.resolved.enable = mkEnableOption "Whether to enable systemd-resolved";
  config = mkIf cfg.enable {
    services.resolved = {
      enable = true;
      dnsovertls = "opportunistic";
    };
  };
}
