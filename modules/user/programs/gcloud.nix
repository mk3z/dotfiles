{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.programs.gcloud;
  inherit (osConfig.mkez.core) homePersistDir;
in {
  options.mkez.programs.gcloud.enable = mkEnableOption "Google Cloud tools";
  config = mkIf cfg.enable {
    home = {
      persistence."${homePersistDir}".directories = [".config/gcloud"];
      packages = [pkgs.google-cloud-sdk];
    };
  };
}
