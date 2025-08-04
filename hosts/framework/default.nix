{
  lib,
  config,
  ...
}: {
  imports = [
    ./boot.nix
    ./disko.nix
    ./hardware-configuration.nix
  ];

  system.stateVersion = "25.05";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  networking = {
    hostName = config.mkez.core.hostname;
    hostId = "e2477a72";
    useDHCP = lib.mkDefault true;
  };
}
