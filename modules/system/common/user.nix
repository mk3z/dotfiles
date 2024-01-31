{
  config,
  pkgs,
  username,
  ...
}: {
  # Get agenix password secret
  age.secrets.password.file = ../../../secrets/password.age;

  # Make the default user
  users = {
    users.${username} = {
      uid = 1000;
      isNormalUser = true;
      createHome = true;
      extraGroups = ["wheel" "networkmanager" "audio" "video"];
      initialPassword = "changeme";
      hashedPasswordFile = config.age.secrets.password.path;
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
}