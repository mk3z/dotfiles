{
  imports = [./nix.nix];
  programs.fish.shellAbbrs = {
    tree = "ls --tree";
    z = "zathura";
    s = "sudo";
  };
}
