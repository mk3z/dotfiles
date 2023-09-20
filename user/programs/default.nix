{ inputs, pkgs, homeDirectory, homePersistDir, ... }: {
  imports = [
    ./doom
    ./firefox
    ./gimp.nix
    ./inkscape.nix
    ./qbittorrent.nix
    ./signal.nix
    ./spotify.nix
    ./speedcrunch.nix
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
  ];

  programs = {
    imv.enable = true;
    mpv.enable = true;
    java = {
      enable = true;
      package = pkgs.jdk11;
    };
  };
}
