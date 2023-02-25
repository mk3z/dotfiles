username: { pkgs, lib, inputs, homePersistDir, ... }:

let
  homeDirectory = "/home/${username}";
in
{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    inputs.doom-emacs.hmModule
    ./sway.nix
  ];

  home = { inherit username homeDirectory; };

  home.persistence."${homePersistDir}${homeDirectory}" = {
    directories = [
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
    gimp
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

  programs = import ./programs { inherit pkgs inputs; };

  services = import ./services { inherit pkgs; };

  home.stateVersion = "22.11";
}
