{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.features.kubernetes;
  inherit (config.mkez.core) sysPersistDir;
  inherit (config.mkez.user) username;
in {
  options.mkez.features.kubernetes.enable = mkEnableOption "Enable Kubernetes";
  config = mkIf cfg.enable {environment.persistence."${sysPersistDir}".users.${username}.directories = [".minikube"];};
}
