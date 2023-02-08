username: { pkgs, impermanence, homePersistDir, doom-emacs, copilot, ... }:

let
  homeDirectory = "/home/${username}";
in
{
  imports = [
    impermanence.nixosModules.home-manager.impermanence
    doom-emacs.hmModule
  ];

  home = { inherit username homeDirectory; };

  home.persistence."${homePersistDir}${homeDirectory}" = {
    directories = [
      ".local/share/z"
      ".ssh"
      ".xkb"
      "Code"
      "Documents"
      "Downloads"
      "Music"
      "Pictures"
      "Projects"
      "Videos"
    ];
    files = [
      ".bash_history"
      ".local/share/fish/fish_history"
    ];
    allowOther = true;
  };

  nix.settings = {
    substituters = [
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  # Disable useless user dirs
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = null;
    publicShare = null;
    templates = null;
  };

  home.packages = with pkgs; [
    colemak-dh
    duf
    du-dust
    fd
    neofetch
    ripgrep
    tldr

    # sway
    swaylock
    wev
    wl-clipboard
    wofi

    # fish
    fishPlugins.fzf-fish
    fishPlugins.pisces
  ];

  wayland.windowManager.sway = {
    enable = true;
    systemdIntegration = true;
    wrapperFeatures.gtk = true;
    config = rec {
      modifier = "Mod4";
      terminal = "foot";
      menu = "wofi --show run";
      bars = [];
      input = {
        "type:keyboard" = {
          xkb_model = "pc105";
          xkb_layout = "matias";
          repeat_delay = "300";
          repeat_rate = "50";
        };
      };
    };
  };

  home.pointerCursor = {
    package = pkgs.phinger-cursors;
    name = "phinger-cursors";
    x11 = {
      enable = true;
      defaultCursor = "phinger-cursors";
    };
  };

  programs = import ./programs { inherit pkgs copilot; };

  services = import ./services { inherit pkgs; };

  home.stateVersion = "22.11";
}
