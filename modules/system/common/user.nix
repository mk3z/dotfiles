{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) types mkOption mkEnableOption;
  cfg = config.mkez.user;
in {
  options.mkez.user = {
    username = mkOption {
      description = "Username";
      type = types.str;
      default = "mkez";
    };
    homeDirectory = mkOption {
      description = "Home directory";
      type = types.str;
      default = "/home/${cfg.username}";
    };
    noPassword = mkEnableOption "Don't set user password";
  };
  config = {
    # Get agenix password secret
    age.secrets =
      if config.mkez.core.hostname == "bastion"
      then {bastion-password.file = ../../../secrets/bastion-password.age;}
      else {password.file = ../../../secrets/password.age;};

    # Make the default user
    users = {
      users.${cfg.username} = {
        uid = 1000;
        isNormalUser = true;
        createHome = true;
        extraGroups = ["wheel" "audio" "video" "dialout"];
        hashedPasswordFile =
          if config.mkez.core.hostname == "bastion"
          then config.age.secrets.bastion-password.path
          else if !cfg.noPassword
          then config.age.secrets.password.path
          else null;
      };

      # Don't allow mutation of users outside of the config.
      mutableUsers = false;

      # Set fish as the default shell for all users
      defaultUserShell = pkgs.fish;
    };

    programs.fish.enable = true;
    environment.shells = [pkgs.fish];

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
