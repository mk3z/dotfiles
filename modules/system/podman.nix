{
  config,
  lib,
  pkgs,
  username,
  homePersistDir,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.podman;
in {
  options.mkez.services.podman.enable = mkEnableOption "Enables Podman";
  config = mkIf cfg.enable {
    virtualisation.podman = {
      enable = true;
      autoPrune.enable = true;
      defaultNetwork.settings.dns_enabled = true;
      extraPackages = mkIf config.mkez.hardware.zfs.enable [pkgs.zfs];
    };

    environment = mkIf (!config.mkez.core.server) {
      systemPackages = with pkgs; [podman-compose];
      persistence.${homePersistDir}.users.${username}.directories = [".local/share/containers"];
    };
  };
}
