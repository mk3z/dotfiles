{
  programs.fish.shellAbbrs =
    import ./nix.nix
    // {
      tree = "ls --tree";
      z = "zathura";
    };
}
