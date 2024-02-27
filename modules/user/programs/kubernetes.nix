{
  lib,
  osConfig,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (osConfig.mkez.core) homePersistDir;
  inherit (osConfig.mkez.user) homeDirectory;
in {
  config = mkIf osConfig.mkez.features.kubernetes.enable {
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
