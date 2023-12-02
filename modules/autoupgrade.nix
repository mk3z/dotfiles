{homeDirectory, ...}: {
  system.autoUpgrade = {
    enable = true;
    flake = "${homeDirectory}/Projects/dotfiles";
    flags = [
      "--update-input"
      "nixpkgs"
      "--update-input"
      "nur"
      "--commit-lock-file"
      "-L"
    ];
    persistent = true;
    dates = "daily";
  };
}
