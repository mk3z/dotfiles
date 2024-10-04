{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.hardware.rtl-sdr;
in {
  options.mkez.programs.rtl-sdr.enable = mkEnableOption "Whether to enable RTL-SDR hardware support";
  config = mkIf cfg.enable {
    hardware.rtl-sdr.enable = true;
    services.sdrplayApi.enable = true;
  };
}
