{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.programs.ydotool;
  inherit (config.mkez.user) username;
in {
  options.mkez.programs.ydotool.enable = mkEnableOption "Whether to enable ydotool";

  config = mkIf cfg.enable {
    programs.ydotool.enable = true;
    users.users.${username}.extraGroups = [config.programs.ydotool.group];
  };
}
