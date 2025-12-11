{
  config,
  inputs,
  pkgs,
  ...
}: let
  inherit (config.mkez.core) sysPersistDir;
  inherit (config.mkez.user) realName email;
in {
  imports = [
    ./console.nix
    ./i18n.nix
    ./keyring.nix
    ./man.nix
    ./networking.nix
    ./nix.nix
    ./user.nix
  ];

  environment = {
    persistence."${sysPersistDir}" = {
      directories = [
        "/etc/NetworkManager"
        "/var/cache"
        "/var/lib"
        "/var/log"
      ];
      files = [
        "/etc/nix/id_rsa"
      ];
    };

    # Required for systemd journal
    etc."machine-id".source = "${sysPersistDir}/etc/machine-id";
  };

  nixpkgs = {
    overlays = [
      inputs.nur.overlays.default
      inputs.helix.overlays.default
    ];
    config.allowUnfree = true;
  };

  # Required for impermanence/home-manager
  programs.fuse.userAllowOther = true;

  # Install age cli tool
  environment.systemPackages = [inputs.agenix.packages.${pkgs.system}.default];
  # Tell age where the keys are
  age.identityPaths = ["${sysPersistDir}/etc/ssh/ssh_host_ed25519_key"];

  programs.git = {
    enable = true;
    config.user = {
      name = realName;
      inherit email;
    };
  };

  security.polkit.enable = true;

  # Allow swaylock to unlock the computer for us
  security.pam.services.swaylock.text = "auth include login";
}
