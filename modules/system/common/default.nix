{
  inputs,
  sysPersistDir,
  ...
}: {
  imports = [
    ./user.nix
    ./nix.nix

    ./console.nix
    ./i18n.nix

    ./networking.nix
    ./xdg.nix
  ];

  environment.persistence."${sysPersistDir}" = {
    directories = [
      "/etc/NetworkManager"
      "/var/cache"
      "/var/lib"
      "/var/log"
    ];
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

  nixpkgs = {
    overlays = [inputs.nur.overlay inputs.fenix.overlays.default];
    config.allowUnfree = true;
  };

  # Required for impermanence/home-manager
  programs.fuse.userAllowOther = true;

  # Install age cli tool
  environment.systemPackages = [inputs.agenix.packages.x86_64-linux.default];
  # Tell age where the keys are
  age.identityPaths = ["${sysPersistDir}/etc/ssh/ssh_host_ed25519_key"];

  programs.git = {
    enable = true;
    config.user = {
      name = "Matias Zwinger";
      email = "matias.zwinger@protonmail.com";
    };
  };

  security.polkit.enable = true;

  # Allow swaylock to unlock the computer for us
  security.pam.services.swaylock.text = "auth include login";
}
