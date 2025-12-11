{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption;
  cfg = config.mkez.hardware.bolt;
in {
  options.mkez.hardware.bolt.enable = mkEnableOption "Thunderbolt";
  config.services.hardware.bolt.enable = cfg.enable;
}
