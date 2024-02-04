{modulesPath, ...}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.luks.devices.crypt = {
    device = "/dev/disk/by-uuid/17270b25-6a17-4901-b243-466fcda76b9a";
    preLVM = true;
  };

  fileSystems = {
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = ["defaults" "size=2G" "mode=755"];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/2E98-B975";
      fsType = "vfat";
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/7171e996-ecd2-48ec-9a2a-93ec1af682ec";
      fsType = "ext4";
    };

    "/persist" = {
      device = "/dev/disk/by-uuid/c9ceddcd-055e-468b-8a6b-7e04f1114b8d";
      fsType = "ext4";
      neededForBoot = true;
    };
  };
  swapDevices = [
    {device = "/dev/disk/by-uuid/d996f8ec-d98d-40b3-aaea-f7c01a4fedcf";}
  ];
}
