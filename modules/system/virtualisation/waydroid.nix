{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.virtualisation.waydroid;
  inherit (config.mkez.core) sysPersistDir;
in {
  options.mkez.virtualisation.waydroid.enable = mkEnableOption "Enable Waydroid";
  config = mkIf cfg.enable {
    virtualisation.waydroid.enable = true;

    environment.persistence."${sysPersistDir}".directories = ["/var/lib/waydroid/lxc"];
  };
}
