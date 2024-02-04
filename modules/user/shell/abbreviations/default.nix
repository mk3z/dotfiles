{
  imports = [./nix.nix];
  programs.fish.shellAbbrs = {
    tree = "ls --tree";
    s = "sudo";
  };
}
