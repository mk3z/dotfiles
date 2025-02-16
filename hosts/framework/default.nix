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

  system.stateVersion = "24.11";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  networking = {
    hostName = config.mkez.core.hostname;
    hostId = "e2477a72";
    useDHCP = lib.mkDefault true;
  };
}
