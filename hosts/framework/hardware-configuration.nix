{modulesPath, ...}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  fileSystems."/persist".neededForBoot = true;

  # zram
  swapDevices = [];
  zramSwap.enable = true;

  services.fwupd.enable = true;
}
