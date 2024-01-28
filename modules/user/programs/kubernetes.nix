{
  lib,
  config,
  pkgs,
  homePersistDir,
  homeDirectory,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.features.kubernetes;
in {
  options.mkez.features.kubernetes.enable = mkEnableOption "Enable Kubernetes";
  config = mkIf cfg.enable {
    programs.k9s = {
      enable = true;
    };

    stylix.targets.k9s.enable = false;

    home = {
      packages = with pkgs; [
        kubectl
        minikube
        kubernetes-helm
        kapp
        kube-bench
        kube-hunter
      ];
      file.".minikube/bin/docker-machine-driver-kvm2".source = "${pkgs.docker-machine-kvm2}/bin/docker-machine-driver-kvm2";
      persistence."${homePersistDir}${homeDirectory}".directories = [
        ".kube"
      ];
    };
  };
}
