{ pkgs, inputs, config, username, sysPersistDir, ... }:

{
  imports = [ ./services ./theming ];

  environment.persistence."${sysPersistDir}" = {
    directories = [ "/etc/NetworkManager" "/var/log" "/var/lib" ];
    files = [
      # Required for systemd journal
      "/etc/machine-id"
      "/etc/nix/id_rsa"
      # SSH keys
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
    ];
  };

  programs.ssh.startAgent = true;

  age = {
    identityPaths = [ "${sysPersistDir}/etc/ssh/ssh_host_ed25519_key" ];
    secrets.password.file = ../secrets/password.age;
  };

  networking.networkmanager.enable = true;

  # Set the time zone.
  time.timeZone = "Europe/Helsinki";

  # Internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IE.UTF-8";
    LC_IDENTIFICATION = "en_IE.UTF-8";
    LC_MEASUREMENT = "en_IE.UTF-8";
    LC_MONETARY = "en_IE.UTF-8";
    LC_NAME = "en_IE.UTF-8";
    LC_NUMERIC = "en_IE.UTF-8";
    LC_PAPER = "en_IE.UTF-8";
    LC_TELEPHONE = "en_IE.UTF-8";
    LC_TIME = "en_IE.UTF-8";
  };

  programs.vim.defaultEditor = true;

  # Console packages
  console.packages = with pkgs; [ colemak-dh ];

  # Configure console keymap
  console.keyMap = "colemak_dh_iso_us";

  # Don't allow mutation of users outside of the config.
  users.mutableUsers = false;

  # Set fish as the default shell for all users
  programs.fish.enable = true;
  environment.shells = with pkgs; [ fish ];
  users.defaultUserShell = pkgs.fish;

  security.polkit.enable = true;

  users.users.root = {
    initialPassword = "changeme";
    passwordFile = config.age.secrets.password.path;
  };

  users.extraUsers.${username} = {
    isNormalUser = true;
    createHome = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
    initialPassword = "changeme";
    passwordFile = config.age.secrets.password.path;
  };

  nix.settings = {
    substituters = [ "https://nix-community.cachix.org" ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings.auto-optimise-store = true;

  # System packages
  environment.systemPackages = with pkgs;
    [ htop ncdu killall parted vim wget ]
    ++ [ inputs.agenix.packages.x86_64-linux.default ];

  security.sudo = {
    extraRules = [{
      users = [ username ];
      commands = [{
        command = "ALL";
        options = [ "NOPASSWD" ];
      }];
    }];
    extraConfig = ''
      # rollback results in sudo lectures after each reboot
      Defaults lecture = never
    '';
  };

  # Required for impermanence/home-manager
  programs.fuse.userAllowOther = true;

  # Hardware Support for Wayland Sway
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
    };
  };

  xdg = {
    portal = {
      wlr.enable = true;
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };

  # Allow swaylock to unlock the computer for us
  security.pam.services.swaylock = { text = "auth include login"; };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
