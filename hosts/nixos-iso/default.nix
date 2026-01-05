{lib, ...}: {
  system.stateVersion = "25.11";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  networking.wireless.enable = false;
}
