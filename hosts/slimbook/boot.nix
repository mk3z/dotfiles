{ config, lib, pkgs, ... }:

{
  boot = {
    loader.efi.canTouchEfiVariables = true;
    loader.grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      mirroredBoots = [{
        devices = [ "/dev/disk/by-uuid/BB94-AEE7" ];
        path = "/boot-fallback";
      }];
    };

    supportedFilesystems = [ "zfs" ];
    zfs.forceImportRoot = false;

    initrd.availableKernelModules =
      [ "nvme" "xhci_pci" "usb_storage" "sd_mod" ];
    initrd.kernelModules = [ "amdgpu" ];
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    kernelParams = [ "nohibernate" ];
  };
}
