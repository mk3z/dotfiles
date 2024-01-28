{
  lib,
  config,
  homePersistDir,
  homeDirectory,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg =
    config.mkez.programs.bitwig;
in {
  options.mkez.programs.bitwig.enable = mkEnableOption "Persist ~/.BitwigStudio";
  config = mkIf cfg.enable {
    home.persistence."${homePersistDir}${homeDirectory}".directories = [".BitwigStudio"];
  };
}
