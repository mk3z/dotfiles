{
  pkgs,
  osConfig,
  ...
}: let
  inherit (osConfig.mkez.user) realName email key;
in {
  home.packages = with pkgs; [
    p7zip
    file
    gh
    libqalculate
    sshuttle
    tlrc
    unzip
    yq-go

    # disk
    duf
    dust
    fd
    ripgrep

    # network
    httpie
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
    imagemagick
    yt-dlp

    # nix
    deadnix
    devenv
    nix-diff
    nix-du
    nix-melt
    nix-output-monitor
    nix-tree
    npins
    nvd
    statix

    # useless stuff
    cmatrix
    cowsay
    fortune
    lolcat
    fastfetch
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
      settings = {
        user = {
          name = realName;
          inherit email;
        };
        commit.verbose = true;
        core = {
          untrackedcache = true;
        };
        fetch = {
          commitgraph = true;
          writeCommitGraph = true;
        };
      };
      signing = {
        signByDefault = true;
        inherit key;
      };
      includes = [
        {
          contents.user.email = "matias.zwinger@aalto.fi";
          condition = "gitdir:~/Projects/Aalto/**";
        }
      ];
    };

    delta.enable = true;

    fzf.enable = true;

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
      enableFishIntegration = true;
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
