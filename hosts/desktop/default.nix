{
  lib,
  config,
  ...
}: {
  imports = [./boot.nix ./hardware-configuration.nix];

  system.stateVersion = "25.05";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  networking = {
    hostName = config.mkez.core.hostname;
    hostId = "33191c49";
    useDHCP = lib.mkDefault true;
  };
}
