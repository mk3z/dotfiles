{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.hardware.yubikey;
  inherit (config.mkez.core) homePersistDir;
  inherit (config.mkez.user) username homeDirectory;
in {
  options.mkez.hardware.yubikey = {
    enable = mkEnableOption "Yubikey support";
    ssh = mkEnableOption "Yubikey GPG SSH authentication";
  };

  config = mkIf cfg.enable {
    services = {
      udev.packages = [pkgs.yubikey-personalization];
      pcscd.enable = true;
    };

    security.pam.services = {
      login.u2fAuth = true;
      sudo.u2fAuth = true;
    };

    environment.systemPackages = with pkgs; [yubikey-manager yubikey-personalization];

    environment.persistence."${homePersistDir}".directories = [
      {
        directory = "${homeDirectory}/.config/Yubico";
        user = username;
        group = "users";
      }
    ];
  };
}
