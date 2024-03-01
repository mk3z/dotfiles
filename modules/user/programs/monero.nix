{
  lib,
  config,
  osConfig,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (osConfig.mkez.core) homePersistDir;
  inherit (osConfig.mkez.user) homeDirectory;
  cfg = config.mkez.programs.monero;
in {
  options.mkez.programs.monero.enable = mkEnableOption "Whether to install the monero client";

  config = mkIf cfg.enable {
    home = {
      packages = [pkgs.monero-cli];
      persistence."${homePersistDir}${homeDirectory}".directories = [".xmr"];
    };
  };
}
