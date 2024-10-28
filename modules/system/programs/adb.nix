{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.programs.adb;
  inherit (config.mkez.user) username;
in {
  options.mkez.programs.adb.enable = mkEnableOption "Enable adb";
  config = mkIf cfg.enable {
    programs.adb.enable = true;
    users.users.${username}.extraGroups = ["adbusers"];
  };
}
