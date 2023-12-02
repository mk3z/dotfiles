{ pkgs, inputs, username, homeDirectory, homePersistDir, ... }:

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    inputs.doom-emacs.hmModule

    ./gui
    ./shell
    ./programs
  ];

  programs.home-manager.enable = true;

  home = {
    inherit username homeDirectory;

    persistence."${homePersistDir}${homeDirectory}" = {
      directories = [
        "Audio"
        "Code"
        "Documents"
        "Music"
        "Pictures"
        "Projects"
        "School"
        "Videos"

        ".cache"
        ".local/share/keyrings"

        ".BitwigStudio"
      ];
      allowOther = true;
    };

    sessionVariables.NIXPKGS_ALLOW_UNFREE = 1;

    stateVersion = "23.11";
  };

  xdg = {
    mimeApps.enable = true;
    # Disable useless user dirs
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = null;
      publicShare = null;
      templates = null;
    };
  };

  nix = {
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings = {
      # Idk why but for some reason hm does not put cache.nixos.org in nix.conf by default
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
      extra-substituters = [
        "https://crane.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "crane.cachix.org-1:8Scfpmn9w+hGdXH/Q9tTLiYAE/2dnJYRJP7kl80GuRk="
      ];
    };
  };

  # FIXME: remove when https://github.com/danth/stylix/issues/180 is fixed
  stylix.targets.xfce.enable = false;
}
