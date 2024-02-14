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
      options = ["defaults" "size=4G" "nr_inodes=0" "mode=755"];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/70E6-6FE0";
      fsType = "vfat";
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/87015bf3-fc2f-4703-8727-a07e5e710a85";
      fsType = "ext4";
    };

    "/persist" = {
      device = "/dev/disk/by-uuid/b33c027c-80be-4522-bdc6-77d7feed6da8";
      fsType = "ext4";
      neededForBoot = true;
    };
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/407d3da9-a711-43ca-aea3-e8538c2f437b";}
  ];
}
