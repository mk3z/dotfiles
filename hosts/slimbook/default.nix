{...}: {
  imports = [./hardware-configuration.nix ./boot.nix];
  system.stateVersion = "23.11";
}
