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
      kernelParams = ["nohibernate"];

      zfs = {
        forceImportRoot = false;
        package = mkIf cfg.unstable pkgs.zfs_unstable;
      };

      extraModprobeConfig = ''
        options zfs l2arc_rebuild_enabled=1 l2arc_write_boost=524288000 l2arc_write_max=524288000 zfs_txg_timeout=300 zfs_dirty_data_max=4174112768 zfs_dirty_data_max_percent=40 l2arc_headroom=12
      '';
    };
  };
}
