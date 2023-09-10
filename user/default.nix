{ pkgs, inputs, username, homePersistDir, ... }:

let homeDirectory = "/home/${username}";
in
{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    inputs.doom-emacs.hmModule

    ./gui
    # Come on Nix, is this really the only way to do this?
    (import ./shell { inherit inputs pkgs homePersistDir homeDirectory; })
    (import ./doom { inherit inputs pkgs homePersistDir homeDirectory; })
    (import ./firefox { inherit pkgs homePersistDir homeDirectory; })
    (import ./vscode.nix { inherit pkgs homePersistDir homeDirectory; })
    (import ./spotify.nix { inherit inputs pkgs homePersistDir homeDirectory; })
    ./speedcrunch.nix
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

      # communication
      signal-desktop
      telegram-desktop
      webcord

      # other
      qbittorrent
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

  nix.settings = {
    substituters = [ "https://nix-community.cachix.org" ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
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
