{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [./hardware-configuration.nix ./boot.nix ./gameserver.nix ./vpn.nix];

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
    ${pkgs.hdparm}/sbin/hdparm -B 64 /dev/sd{a,b,d}
    ${pkgs.hdparm}/sbin/hdparm -S 120 /dev/sd{a,b,d}
  '';

  # For bastion borg backups
  users.users.bastion = {
    group = "bastion";
    isSystemUser = true;
    shell = pkgs.bashInteractive;
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDwGyydra5JU3FSR8IqLUi/HDJJWGGdZCzcQPdqEdh4c"];
  };
  users.groups.bastion = {};
  environment.systemPackages = [pkgs.borgbackup];
}
