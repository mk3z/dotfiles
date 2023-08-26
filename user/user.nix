username:
{ pkgs, lib, inputs, homePersistDir, ... }:

let homeDirectory = "/home/${username}";
in {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    inputs.doom-emacs.hmModule
    ./hyprland.nix
  ];

  home = { inherit username homeDirectory; };

  home.persistence."${homePersistDir}${homeDirectory}" = {
    directories = [
      ".config/Signal"
      ".config/GIMP"
      ".config/VSCodium/Preferences"
      ".cache"
      ".local/share/keyrings"
      ".local/share/TelegramDesktop"
      ".mozilla/firefox"
      ".ssh"
      "Code"
      "Documents"
      "Music"
      "Pictures"
      "Projects"
      "Videos"
    ];
    files =
      [ ".bash_history" ".local/share/doom" ".local/share/fish/fish_history" ];
    allowOther = true;
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

  stylix.targets = {
    emacs.enable = false;
    swaylock.useImage = false;
    vscode.enable = false;
    waybar.enable = false;
  };

  home.packages = with pkgs; [
    colemak-dh
    gimp
    obs-studio
    pavucontrol
    signal-desktop
    telegram-desktop
    webcord

    # programming (needed by Emacs)
    aspell
    aspellDicts.en
    aspellDicts.en-science
    aspellDicts.en-computers
    python3
    ## Github Copilot
    nodejs
    ## Nix
    rnix-lsp
    nixfmt

    # cli utilities
    duf
    du-dust
    fd
    ffmpeg
    graphviz
    inxi
    lm_sensors
    pciutils
    ripgrep
    sxiv
    tldr
    usbutils

    # nix utilities
    nix-diff
    nix-du
    nix-melt
    nix-output-monitor
    nix-tree
    nixfmt
    nvd
    statix

    # wayland
    hyprpicker
    wev
    wl-clipboard

    # fish
    fishPlugins.fzf-fish
    fishPlugins.pisces

    # useless stuff
    cmatrix
    cowsay
    fortune
    lolcat
    neofetch
    sl
    toilet
  ];

  home = {
    sessionVariables = {
      EMACS_PATH_COPILOT = "${inputs.copilot}";
      NIXOS_OZONE_WL = "1";
    };
    file = {
      ".vscode-oss/argv.json" = {
        recursive = true;
        text = ''
          {
            "enable-features": "UseOzonePlatform",
            "ozone-platform" : "wayland",
            "password-store":"gnome"
          }
        '';
      };
    };
  };

  programs = import ./programs { inherit pkgs lib inputs; };

  services = import ./services { inherit pkgs; };

  home.stateVersion = "23.11";
}
