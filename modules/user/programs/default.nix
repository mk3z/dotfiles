{pkgs, ...}: {
  imports = [
    ./bitwarden.nix
    ./bitwig.nix
    ./chromium.nix
    ./claude.nix
    ./discord.nix
    ./firefox
    ./gimp.nix
    ./gnuradio.nix
    ./gpg.nix
    ./inkscape.nix
    ./kubernetes.nix
    ./libreoffice.nix
    ./lutris.nix
    ./monero.nix
    ./mpv.nix
    ./neomutt
    ./octave.nix
    ./prism.nix
    ./qbittorrent.nix
    ./rpcs3.nix
    ./signal.nix
    ./sioyek.nix
    ./spotify.nix
    ./speedcrunch.nix
    ./syncthing.nix
    ./telegram.nix
    ./thunderbird.nix
    ./vscode.nix
    ./wine.nix
  ];

  home.packages = with pkgs; [
    # utilities
    pavucontrol

    # media
    friture
    obs-studio
    ytfzf

    #networking
    nmap
    wireshark

    # other
    quickemu
    transmission_4
  ];

  programs = {
    imv.enable = true;
    java = {
      enable = true;
      package = pkgs.jdk11;
    };
  };
}
