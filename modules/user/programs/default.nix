{pkgs, ...}: {
  imports = [
    ./bitwig.nix
    ./doom
    ./firefox
    ./gimp.nix
    ./haskell.nix
    ./helix.nix
    ./inkscape.nix
    ./kubernetes.nix
    ./mpv.nix
    ./neovim
    ./qbittorrent.nix
    ./signal.nix
    ./spotify.nix
    ./speedcrunch.nix
    ./syncthing.nix
    ./telegram.nix
    ./vscode.nix
    ./webcord.nix
  ];

  home.packages = with pkgs; [
    # utilities
    pavucontrol

    # media
    obs-studio
    ytfzf

    # other
    quickemu
    ungoogled-chromium
    (octave.withPackages (opkgs: with opkgs; [symbolic statistics]))
  ];

  programs = {
    imv.enable = true;
    java = {
      enable = true;
      package = pkgs.jdk11;
    };
  };
}
