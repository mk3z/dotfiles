{
  config,
  osConfig,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.programs.chromium;
  inherit (osConfig.mkez.core) homePersistDir;
  inherit (osConfig.mkez.user) homeDirectory;
in {
  options.mkez.programs.chromium.enable = mkEnableOption "enable Chromium";
  config = mkIf cfg.enable {
    home.persistence."${homePersistDir}${homeDirectory}".directories = [".config/chromium"];

    programs.chromium = {
      enable = true;
      extensions = [
        {id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";} # Dark Reader
      ];
    };
  };
}
