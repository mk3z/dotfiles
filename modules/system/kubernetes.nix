{
  lib,
  config,
  username,
  sysPersistDir,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.features.kubernetes;
in {
  options.mkez.features.kubernetes.enable = mkEnableOption "Enable Kubernetes";
  config = mkIf cfg.enable {environment.persistence."${sysPersistDir}".users.${username}.directories = [".minikube"];};
}
