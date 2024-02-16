{
  boot = {
    initrd = {
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "sd_mod"];
      kernelModules = ["dm-snapshot" "virtio_gpu"];
    };
    kernelModules = ["kvm-amd"];
    extraModulePackages = [];
    kernelParams = ["console=tty"];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
