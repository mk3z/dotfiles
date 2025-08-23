{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.mosh;
in {
  options.mkez.services.krb.enable = mkEnableOption "enable Kerberos";

  config = mkIf cfg.enable {
    security.krb5 = {
      enable = true;
      settings.include = [./cern.conf];
    };
  };
}
