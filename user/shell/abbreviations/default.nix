{
  programs.fish.shellAbbrs = import ./git.nix // import ./nix.nix // {

    tree = "ls --tree";
    z = "zathura";
  };
}
