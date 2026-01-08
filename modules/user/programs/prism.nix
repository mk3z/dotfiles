{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.programs.prism;
  inherit (osConfig.mkez.core) homePersistDir;
in {
  options.mkez.programs.prism.enable = mkEnableOption "Whether to enable Prism Launcher";
  config = mkIf cfg.enable {
    home = {
      packages = [pkgs.prismlauncher];
      persistence."${homePersistDir}".directories = [".local/share/PrismLauncher"];
    };
  };
}
