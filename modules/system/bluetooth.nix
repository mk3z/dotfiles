{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.hw.bluetooth;
in {
  options.hw.bluetooth.enable = mkEnableOption "Enable Bluetooth";
  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
  };
}
