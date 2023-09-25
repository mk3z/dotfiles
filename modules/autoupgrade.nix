{ homeDirectory, ... }:
{
  system.autoUpgrade = {
    enable = true;
    flake = "${homeDirectory}/Projects/dotfiles";
    flags = [
      "--update-input"
      "nixpkgs"
      "--commit-lock-file"
      "-L"
    ];
    persistent = true;
    dates = "daily";
  };
}
