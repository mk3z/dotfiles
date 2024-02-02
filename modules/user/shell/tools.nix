{pkgs, ...}: {
  home.packages = with pkgs; [
    file
    gh
    sshuttle
    tldr
    unzip

    # disk
    duf
    du-dust
    fd
    ripgrep

    # network
    ldns
    mtr
    nethogs
    whois

    # hardware
    inxi
    lm_sensors
    pciutils
    usbutils

    # media
    ffmpeg
    graphviz

    # nix
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
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        batgrep
        batwatch
      ];
    };

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

    less = {
      enable = true;
      keys = ''
        n forw-line
        e back-line
        k repeat-search
        K reverse-search
      '';
    };

    lsd = {
      enable = true;
      enableAliases = true;
    };

    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };

    nix-index-database.comma.enable = true;

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
