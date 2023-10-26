{
  n = "nix";

  nb = "nix build";
  nbi = "nix build --impure";

  nd = "nix develop";
  ndi = "nix develop --impure";

  nf = "nix flake";
  nfc = "nix flake check";
  nfi = "nix flake init";
  nfm = "nix flake metadata";
  nfn = "nix flake new";
  nfs = "nix flake show";
  nfu = "nix flake update";

  nr = "nix run";
  nri = "nix run --impure";

  nsr = "nix search";

  ns = "nix-shell";
  nsi = "nix shell --impure";

  nrepl = "nix repl";

  nlog = "nix log";

  ne = "nix edit";

  nl = "nix-locate";

  nm = "nix-melt";

  nt = "nix-tree";

  nors = "sudo nixos-rebuild switch -v --flake /home/matias/Projects/dotfiles#slimbook --log-format internal-json --show-trace &| nom --json";
}
