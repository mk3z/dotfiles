{
  lib,
  config,
  pkgs,
  username,
  ...
}: let
  inherit (lib) mkEnableOption;
  cfg = config.mkez.user;
in {
  options.mkez.user.noPassword = mkEnableOption "Don't set user password";
  config = {
    # Get agenix password secret
    age.secrets.password.file = ../../../secrets/password.age;

    # Make the default user
    users = {
      users.${username} = {
        uid = 1000;
        isNormalUser = true;
        createHome = true;
        extraGroups = ["wheel" "audio" "video"];
        initialPassword = "";
        hashedPasswordFile =
          if config.core.hostname == "bastion"
          then config.age.secrets.bastion-password.path
          else if !cfg.noPassword
          then config.age.secrets.password.path
          else {};
      };

      # Don't allow mutation of users outside of the config.
      mutableUsers = false;

      # Set fish as the default shell for all users
      defaultUserShell = pkgs.fish;
    };

    programs.fish.enable = true;
    environment.shells = with pkgs; [fish];

    # Disable systemd emergency mode because root user is disabled
    systemd.enableEmergencyMode = false;

    security.sudo = {
      execWheelOnly = true;
      extraConfig = ''
        # rollback results in sudo lectures after each reboot
        Defaults lecture = never
      '';
    };
  };
}
