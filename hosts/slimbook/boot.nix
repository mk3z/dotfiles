{ pkgs, ... }:

{
  boot = {

    initrd.availableKernelModules =
      [ "nvme" "xhci_pci" "usb_storage" "sd_mod" ];
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];

    # Bootloader can touch EFI variables
    loader.efi.canTouchEfiVariables = true;

    loader.grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      # Mirrored boot partition
      mirroredBoots = [{
        devices = [ "/dev/disk/by-uuid/BB94-AEE7" ];
        path = "/boot-fallback";
      }];
    };
  };

}
