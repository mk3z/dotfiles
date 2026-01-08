{
  config,
  osConfig,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.programs.chromium;
  inherit (osConfig.mkez.core) homePersistDir;
in {
  options.mkez.programs.chromium.enable = mkEnableOption "enable Chromium";
  config = mkIf cfg.enable {
    home.persistence."${homePersistDir}".directories = [".config/chromium"];

    programs.chromium = {
      enable = true;
      extensions = [
        {id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";} # Dark Reader
      ];
    };
  };
}
