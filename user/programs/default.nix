{ inputs, pkgs, homeDirectory, homePersistDir, ... }: {
  imports = [
    ./doom
    ./firefox
    ./vscode.nix
    ./spotify.nix
    ./speedcrunch.nix
  ];
}
