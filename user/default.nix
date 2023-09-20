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

    packages = with pkgs; [
      # utilities
      pavucontrol

      # media
      gimp
      inkscape
      obs-studio
      ytfzf

      # communication
      signal-desktop
      telegram-desktop
      webcord

      # other
      qbittorrent
      quickemu
      ungoogled-chromium
    ];

    persistence."${homePersistDir}${homeDirectory}" = {
      directories = [
        "Code"
        "Documents"
        "Music"
        "Pictures"
        "Projects"
        "School"
        "Videos"

        ".cache"
        ".local/share/containers"
        ".local/share/keyrings"

        ".config/Signal"
        ".config/GIMP"
        ".config/WebCord"
        ".local/share/TelegramDesktop"
      ];
      allowOther = true;
    };

    stateVersion = "23.11";
  };

  nix = {
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings = {
      # Idk why but for some reason hm does not put cache.nixos.org in nix.conf by default
      substituters = [ "https://cache.nixos.org" "https://nix-community.cachix.org" ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  programs = {
    imv.enable = true;
    mpv.enable = true;
    #TODO: maybe move somewhere else
    java = {
      enable = true;
      package = pkgs.jdk11;
    };
  };

  xdg.mimeApps.enable = true;

  # Disable useless user dirs
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = null;
    publicShare = null;
    templates = null;
  };
}
