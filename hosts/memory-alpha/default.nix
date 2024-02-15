{
  lib,
  config,
  ...
}: {
  imports = [./hardware-configuration.nix ./boot.nix];

  system.stateVersion = "23.11";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  networking = {
    hostName = config.mkez.core.hostname;
    hostId = "4a49e359";
    useDHCP = lib.mkDefault true;
  };
}
