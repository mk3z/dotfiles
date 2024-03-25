{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [./hardware-configuration.nix ./boot.nix ./gameserver.nix];

  system.stateVersion = "23.11";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  networking = {
    hostName = config.mkez.core.hostname;
    hostId = "4a49e359";
    useDHCP = lib.mkDefault true;
  };

  systemd.services = {
    fs-mount.enable = false;
    NetworkManager-wait-online.enable = false;
  };

  powerManagement.powerUpCommands = ''
    ${pkgs.hdparm}/sbin/hdparm -B 64 /dev/sd{a,b,c}
    ${pkgs.hdparm}/sbin/hdparm -S 120 /dev/sd{a,b,c}
  '';
}
