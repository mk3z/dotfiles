{...}: {
  imports = [./hardware-configuration.nix ./boot.nix];
  networking.hostName = "slimbook";
  system.stateVersion = "23.11";
}
