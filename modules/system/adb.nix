{
  lib,
  config,
  username,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.features.adb;
in {
  options.mkez.features.adb.enable = mkEnableOption "Enable adb";
  config = mkIf cfg.enable {
    programs.adb.enable = true;
    users.users.${username}.extraGroups = ["adbusers"];
  };
}
