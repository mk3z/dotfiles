{pkgs, ...}: {
  imports = [
    ./bitwarden.nix
    ./bitwig.nix
    ./firefox
    ./gimp.nix
    ./gnuradio.nix
    ./gpg.nix
    ./haskell.nix
    ./inkscape.nix
    ./kubernetes.nix
    ./libreoffice.nix
    ./lutris.nix
    ./monero.nix
    ./mpv.nix
    ./neomutt
    ./prism.nix
    ./qbittorrent.nix
    ./rpcs3.nix
    ./signal.nix
    ./sioyek.nix
    ./spotify.nix
    ./speedcrunch.nix
    ./syncthing.nix
    ./telegram.nix
    ./vscode.nix
    ./webcord.nix
    ./wine.nix
  ];

  home.packages = with pkgs; [
    # utilities
    pavucontrol

    # media
    friture
    obs-studio
    ytfzf

    # other
    quickemu
    transmission_4
    ungoogled-chromium
    (octaveFull.withPackages (opkgs: with opkgs; [communications signal statistics symbolic]))
  ];

  programs = {
    imv.enable = true;
    java = {
      enable = true;
      package = pkgs.jdk11;
    };
  };
}
