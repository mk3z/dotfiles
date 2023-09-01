{ config, lib, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  fileSystems = {
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=2G" "mode=755" ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/BB3C-0CD8";
      fsType = "vfat";
    };

    "/boot-fallback" = {
      device = "/dev/disk/by-uuid/BB94-AEE7";
      fsType = "vfat";
    };

    "/nix" = {
      device = "rpool/nixos/nix";
      fsType = "zfs";
    };

    "/persist" = {
      device = "rpool/nixos/persist";
      fsType = "zfs";
      neededForBoot = true;
    };
  };

  # zram
  swapDevices = [ ];
  zramSwap.enable = true;

  networking = {
    useDHCP = lib.mkDefault true;
    hostId = "f51d068a";
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
