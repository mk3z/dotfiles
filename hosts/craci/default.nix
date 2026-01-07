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

  system.stateVersion = "25.11";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  networking = {
    hostName = config.mkez.core.hostname;
    hostId = "971e15d3";
    useDHCP = lib.mkDefault true;
  };
}
