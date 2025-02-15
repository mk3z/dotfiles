{
  lib,
  config,
  ...
}: {
  imports = [./hardware-configuration.nix ./boot.nix];

  system.stateVersion = "24.11";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  networking = {
    hostName = config.mkez.core.hostname;
    hostId = "f51d068a";
    useDHCP = lib.mkDefault true;
  };
}
