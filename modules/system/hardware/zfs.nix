{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) types mkOption mkEnableOption mkIf;
  cfg = config.mkez.hardware.zfs;
in {
  options.mkez.hardware.zfs = {
    enable = mkEnableOption "Enable ZFS support";
    unstable = mkOption {
      description = "Whether to use unstable ZFS";
      type = types.bool;
      default = true;
    };
  };
  config = mkIf cfg.enable {
    services.zfs.autoScrub = {
      enable = true;
      interval = "weekly";
    };

    boot = {
      supportedFilesystems = ["zfs"];
      kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
      kernelParams = ["nohibernate"];

      zfs = {
        forceImportRoot = false;
        package = mkIf cfg.unstable pkgs.zfs_unstable;
      };
    };
  };
}
