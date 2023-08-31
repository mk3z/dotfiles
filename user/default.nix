{ pkgs, lib, inputs, username, homePersistDir, ... }:

let homeDirectory = "/home/${username}";
in {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    inputs.doom-emacs.hmModule

    ./gui
    # Come on Nix, is this really the only way to do this?
    (import ./shell { inherit inputs pkgs homePersistDir homeDirectory; })
    (import ./doom { inherit inputs pkgs homePersistDir homeDirectory; })
    (import ./firefox { inherit pkgs homePersistDir homeDirectory; })
    (import ./vscode { inherit pkgs homePersistDir homeDirectory; })
  ];

  programs.home-manager.enable = true;

  home = {
    inherit username homeDirectory;

    packages = with pkgs; [
      gimp
      obs-studio
      pavucontrol
      signal-desktop
      telegram-desktop
      webcord
    ];

    persistence."${homePersistDir}${homeDirectory}" = {
      directories = [
        "Code"
        "Documents"
        "Music"
        "Pictures"
        "Projects"
        "Videos"

        ".cache"
        ".local/share/keyrings"
        ".ssh"

        ".config/Signal"
        ".config/GIMP"
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
