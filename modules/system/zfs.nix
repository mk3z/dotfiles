{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.hw.zfs;
in {
  options.hw.zfs.enable = mkEnableOption "Enable ZFS support";
  config = mkIf cfg.enable {
    services.zfs.autoScrub.enable = true;

    boot = {
      supportedFilesystems = ["zfs"];
      kernelPackages =
        (pkgs.zfsUnstable.override {
          removeLinuxDRM = pkgs.hostPlatform.isAarch64;
        })
        .latestCompatibleLinuxPackages;
      kernelParams = ["nohibernate"];

      zfs = {
        forceImportRoot = false;
        removeLinuxDRM = true;
        enableUnstable = true;
      };
    };
  };
}
