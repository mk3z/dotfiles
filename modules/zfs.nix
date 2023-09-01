{ pkgs, ... }:

{
  services.zfs.autoScrub.enable = true;

  boot = {
    supportedFilesystems = [ "zfs" ];
    kernelPackages = (pkgs.zfsUnstable.override {
      removeLinuxDRM = pkgs.hostPlatform.isAarch64;
    }).latestCompatibleLinuxPackages;
    kernelParams = [ "nohibernate" ];

    zfs = {
      forceImportRoot = false;
      removeLinuxDRM = true;
      enableUnstable = true;
    };
  };
}
