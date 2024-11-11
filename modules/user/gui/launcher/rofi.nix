{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkOption mkIf types;
  cfg = config.mkez.gui.launcher.rofi;
  inherit (config.programs) rofi;
in {
  options.mkez.gui.launcher.rofi = {
    enable = mkOption {
      type = types.bool;
      default = config.mkez.gui.launcher.primary == "rofi";
      description = "Whether to enable Rofi";
    };
  };

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
    };
    mkez.gui.launcher.command = "${rofi.package}/bin/rofi";
  };
}
