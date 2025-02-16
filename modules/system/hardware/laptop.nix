{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.hardware.laptop;
in {
  options.mkez.hardware.laptop.enable = mkEnableOption "This device is a laptop";

  config = mkIf cfg.enable {
    powerManagement = {
      enable = true;
      powertop.enable = true;
    };

    hardware.brillo.enable = true;
  };
}
