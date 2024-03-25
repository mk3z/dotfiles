{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption mkEnableOption types;
  cfg = config.mkez.core;
in {
  options.mkez.core = {
    hostname = mkOption {
      description = "System hostname";
      type = types.str;
    };
    sysPersistDir = mkOption {
      description = "System persistence directory";
      type = types.str;
      default = "/persist";
    };
    homePersistDir = mkOption {
      description = "User persistence directory";
      type = types.str;
      default = cfg.sysPersistDir;
    };
    lanInterface = mkOption {
      description = "Primary LAN network interface name";
      type = types.nullOr types.str;
      default = null;
    };
    server = mkEnableOption "Whether this host is a server";
  };
}
