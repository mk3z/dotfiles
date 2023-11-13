{ inputs, pkgs, homeDirectory, homePersistDir, ... }: {
  imports = [
    ./doom
    ./firefox
    ./gimp.nix
    ./inkscape.nix
    ./mpv.nix
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
    (octave.withPackages (opkgs: with opkgs; [ symbolic statistics ]))
  ];

  programs = {
    imv.enable = true;
    java = {
      enable = true;
      package = pkgs.jdk11;
    };
  };
}
