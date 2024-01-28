{lib, ...}: let
  inherit (lib) mkOption types;
in {
  options.mkez.core.hostname = mkOption {
    description = "System hostname";
    type = types.str;
  };
}
