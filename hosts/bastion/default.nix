{
  lib,
  config,
  ...
}: {
  imports = [./hardware-configuration.nix ./boot.nix ./decrypt.nix];

  system.stateVersion = "23.11";
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";

  networking = {
    hostName = config.mkez.core.hostname;
    hostId = "c34261c9";
    useDHCP = true;
  };
}
