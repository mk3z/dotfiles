{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.printing;
in {
  options.mkez.services.printing.enable = mkEnableOption "Enable printing";
  config = mkIf cfg.enable {
    services.printing.enable = true;

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
