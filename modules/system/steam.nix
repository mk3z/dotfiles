{
  lib,
  config,
  username,
  homePersistDir,
  homeDirectory,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.features.steam;
in {
  options.features.steam.enable = mkEnableOption "Enable Steam";
  config = mkIf cfg.enable {
    programs.steam.enable = true;
    environment.persistence."${homePersistDir}".directories = [
      {
        directory = "${homeDirectory}/.local/share/Steam";
        user = username;
        group = "users";
      }
    ];
  };
}
