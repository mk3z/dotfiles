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
      persistence."${homePersistDir}".directories = [
        ".local/share/lutris"
        ".local/share/games"
      ];
    };
  };
}
