{modulesPath, ...}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  fileSystems = {
    "/" = {
      device = "none";
      fsType = "tmpfs";
      # NOTE: nr_inodes=0 is not encouraged in kernel docs:
      # "It is generally unwise to mount with such options, since it allows any
      # user with write access to use up all the memory on the machine; but
      # enhances the scalability of that instance in a system with many cpus
      # making intensive use of it."
      options = ["defaults" "size=8G" "nr_inodes=0" "mode=755"];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/C161-94D7";
      fsType = "vfat";
    };

    "/boot-fallback" = {
      device = "/dev/disk/by-uuid/C0DA-0A30";
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
  swapDevices = [];
  zramSwap.enable = true;
}
