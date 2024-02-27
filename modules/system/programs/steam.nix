{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.mkez.programs.steam;
  inherit (config.mkez.core) homePersistDir;
  inherit (config.mkez.user) username homeDirectory;
in {
  options.mkez.programs.steam.enable = mkEnableOption "Enable Steam";
  config = mkIf cfg.enable {
    programs = {
      steam.enable = true;
      gamemode = {
        enable = true;
        enableRenice = true;
        settings = {
          general.renice = 10;
          custom = {
            start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
            end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
          };
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
