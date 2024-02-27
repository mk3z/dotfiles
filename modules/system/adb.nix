{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.features.adb;
  inherit (config.mkez.user) username;
in {
  options.mkez.features.adb.enable = mkEnableOption "Enable adb";
  config = mkIf cfg.enable {
    programs.adb.enable = true;
    users.users.${username}.extraGroups = ["adbusers"];
  };
}
