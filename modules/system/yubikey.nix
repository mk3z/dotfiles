{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.features.yubikey;
  inherit (config.mkez.core) homePersistDir;
  inherit (config.mkez.user) username homeDirectory;
in {
  options.mkez.features.yubikey.enable = mkEnableOption "Whether to enable Yubikey support";

  config = mkIf cfg.enable {
    services = {
      udev.packages = [pkgs.yubikey-personalization];
      pcscd.enable = true;
    };

    security.pam.services = {
      login.u2fAuth = true;
      sudo.u2fAuth = true;
    };

    environment.systemPackages = with pkgs; [yubikey-manager];

    environment.persistence."${homePersistDir}".directories = [
      {
        directory = "${homeDirectory}/.config/Yubico";
        user = username;
        group = "users";
      }
    ];
  };
}
