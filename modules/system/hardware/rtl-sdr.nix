{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mkez.user) username;
  cfg = config.mkez.hardware.rtl-sdr;
in {
  options.mkez.hardware.rtl-sdr.enable = mkEnableOption "Whether to enable RTL-SDR hardware support";
  config = mkIf cfg.enable {
    hardware.rtl-sdr.enable = true;
    services.sdrplayApi.enable = true;
    users.users.${username}.extraGroups = ["plugdev"];
  };
}
