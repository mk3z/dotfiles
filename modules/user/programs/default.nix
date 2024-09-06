{pkgs, ...}: {
  imports = [
    ./bitwarden.nix
    ./bitwig.nix
    ./doom
    ./firefox
    ./gimp.nix
    ./gpg.nix
    ./haskell.nix
    ./helix.nix
    ./inkscape.nix
    ./kubernetes.nix
    ./lutris.nix
    ./monero.nix
    ./mpv.nix
    ./neovim
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
    obs-studio
    ytfzf

    # other
    quickemu
    transmission_4
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
