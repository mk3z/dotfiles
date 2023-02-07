{ ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./boot.nix
    ];
  system.stateVersion = "21.11";
}
