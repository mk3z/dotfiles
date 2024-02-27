{
  osConfig,
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg =
    config.mkez.programs.bitwig;
  inherit (osConfig.mkez.core) homePersistDir;
  inherit (osConfig.mkez.user) homeDirectory;
in {
  options.mkez.programs.bitwig.enable = mkEnableOption "Persist ~/.BitwigStudio";
  config = mkIf cfg.enable {
    home.persistence."${homePersistDir}${homeDirectory}".directories = [".BitwigStudio"];
  };
}
