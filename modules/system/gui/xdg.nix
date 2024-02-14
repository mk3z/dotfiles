{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf (!config.mkez.core.server) {
    xdg = {
      portal = {
        wlr.enable = true;
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-hyprland
        ];
        config.common.default = "*";
      };
    };
  };
}
