{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.programs.rpcs3;
  inherit (osConfig.mkez.core) homePersistDir;
  inherit (osConfig.mkez.user) homeDirectory;
in {
  options.mkez.programs.rpcs3.enable = mkEnableOption "Whether to enable RPCS3";
  config = mkIf cfg.enable {
    home = {
      packages = [pkgs.rpcs3];
      persistence."${homePersistDir}${homeDirectory}".directories = [".config/rpcs3"];
    };
  };
}
