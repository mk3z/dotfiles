{lib, ...}: {
  imports = [
    ./boot.nix
    ./decrypt.nix
    ./hardware-configuration.nix
    ./network.nix
  ];

  system.stateVersion = "23.11";
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
