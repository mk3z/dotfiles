{lib, ...}: let
  inherit (lib) mkOption mkEnableOption types;
in {
  options.mkez.core = {
    hostname = mkOption {
      description = "System hostname";
      type = types.str;
    };
    server = mkEnableOption "Whether this host is a server";
  };
}
