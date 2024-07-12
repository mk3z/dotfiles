{
  lib,
  config,
  osConfig,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.mkez.programs.lutris;
  inherit (osConfig.mkez.core) homePersistDir;
  inherit (osConfig.mkez.user) homeDirectory;
in {
  options.mkez.programs.lutris.enable = mkEnableOption "Enable Lutris";
  config = mkIf cfg.enable {
    home = {
      packages = [
        (pkgs.lutris.override {
          extraLibraries = pkgs:
            with pkgs; [
              icu
              openssl
            ];
        })
      ];
      persistence."${homePersistDir}${homeDirectory}".directories = [
        ".local/share/lutris"
        ".local/share/games"
      ];
    };
  };
}
