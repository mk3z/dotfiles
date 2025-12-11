{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.virtualisation.docker;
  inherit (config.mkez.user) username;
in {
  options.mkez.virtualisation.docker.enable = mkEnableOption "Enable Docker";
  config = mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      autoPrune.enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
        daemon.settings = {
          dns = [
            "9.9.9.9"
            "1.1.1.1"
          ];
        };
      };
      storageDriver = "overlay2";
    };
    environment.systemPackages = with pkgs; [docker-compose];
    users.users.${username}.extraGroups = ["docker"];

    systemd.services."user@".serviceConfig.Delegate = "cpu cpuset io memory pids";
  };
}
