{
  lib,
  config,
  pkgs,
  username,
  homePersistDir,
  homeDirectory,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.mkez.programs.steam;
in {
  options.mkez.programs.steam.enable = mkEnableOption "Enable Steam";
  config = mkIf cfg.enable {
    programs = {
      steam.enable = true;
      gamemode = {
        enable = true;
        enableRenice = true;
        settings.custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
        };
      };
    };
    environment.persistence."${homePersistDir}".directories = [
      {
        directory = "${homeDirectory}/.local/share/Steam";
        user = username;
        group = "users";
      }
    ];
  };
}
