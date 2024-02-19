{
  boot = {
    initrd = {
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "sd_mod"];
      kernelModules = ["dm-snapshot"];
    };
    kernelModules = ["kvm-amd"];
    extraModulePackages = [];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    zfs.extraPools = ["rpool"];
  };
}
