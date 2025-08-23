{
  lib,
  config,
  ...
}: let
  inherit (lib) types mkOption mkIf;
  cfg = config.mkez.services.mosh;
in {
  options.mkez.services.krb.enable = mkOption {
    default = config.mkez.services.krb.enable;
    type = types.bool;
    description = "enable Kerberos";
  };

  config = mkIf cfg.enable {
    security.krb5 = {
      enable = true;
      settings.include = ["cern.conf"];
    };
  };
}
