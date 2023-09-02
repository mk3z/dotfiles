{ pkgs, ... }:

{
  home.packages = with pkgs; [
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
    tldr
    unzip
    usbutils

    # nix utilities
    deadnix
    nix-diff
    nix-du
    nix-melt
    nix-output-monitor
    nix-tree
    nixfmt
    nvd
    statix

    # useless stuff
    cmatrix
    cowsay
    fortune
    lolcat
    neofetch
    onefetch
    sl
    toilet
  ];

  programs = {

    bat.enable = true;

    git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      userName = "Matias Zwinger";
      userEmail = "matias.zwinger@protonmail.com";
      extraConfig.commit.verbose = true;
      delta.enable = true;
    };

    fzf.enable = true;

    jq.enable = true;

    lsd = {
      enable = true;
      enableAliases = true;
    };

    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };

    vim = {
      enable = true;
      extraConfig = ''
        noremap e k
        noremap i l
        noremap k n
        noremap l u
        noremap m h
        noremap n j
        noremap u i
        noremap E K
        noremap I L
        noremap K N
        noremap L U
        noremap M H
        noremap N J
        noremap U I
      '';
    };

  };
}
