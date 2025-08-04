{
  lib,
  config,
  ...
}: {
  imports = [./hardware-configuration.nix ./boot.nix];

  system.stateVersion = "25.05";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  networking = {
    hostName = config.mkez.core.hostname;
    hostId = "f51d068a";
    useDHCP = lib.mkDefault true;
  };
}
