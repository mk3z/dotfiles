{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption;
  cfg = config.mkez.programs.flipperzero;
in {
  options.mkez.programs.flipperzero.enable = mkEnableOption "Whether to enable Flipper Zero udev rules";
  config.hardware.flipperzero.enable = cfg.enable;
}
