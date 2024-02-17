{modulesPath, ...}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot.initrd.luks.devices."crypted".device = "/dev/sda2";

  fileSystems = {
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = ["defaults" "size=2G" "mode=755"];
    };

    "/nix" = {
      device = "/dev/disk/by-label/nix";
      fsType = "ext4";
    };

    "/persist" = {
      device = "/dev/disk/by-label/persist";
      fsType = "ext4";
      neededForBoot = true;
    };

    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/0e019a60-8732-4663-8e48-e590e0580e25";}
  ];
}
