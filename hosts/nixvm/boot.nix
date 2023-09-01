{
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.editor = false;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices = {
    enc = {
      device = "/dev/disk/by-label/enc";
      preLVM = true;
      allowDiscards = true;
    };
  };

}
