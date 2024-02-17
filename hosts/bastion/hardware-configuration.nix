{modulesPath, ...}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  fileSystems = {
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = ["defaults" "size=2G" "mode=755"];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/39be7cfb-a682-4ea5-a174-d236982b66c2";
      fsType = "ext4";
    };

    "/persist" = {
      device = "/dev/disk/by-uuid/e6eaf238-88ea-4275-b378-bfaa61459eec";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/83E2-493B";
      fsType = "vfat";
    };
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/0e019a60-8732-4663-8e48-e590e0580e25";}
  ];
}
