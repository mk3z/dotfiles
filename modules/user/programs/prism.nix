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
  inherit (osConfig.mkez.user) homeDirectory;
in {
  options.mkez.programs.prism.enable = mkEnableOption "Whether to enable Prism Launcher";
  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [prismlauncher];
      persistence."${homePersistDir}${homeDirectory}".directories = [".local/share/PrismLauncher"];
    };
  };
}
