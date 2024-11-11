{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;

  inherit (config.mkez.user) username;
  inherit (config.home-manager.users.${username}.mkez.gui) wm;
in {
  config = mkIf (!config.mkez.core.server) {
    xdg = {
      portal = {
        wlr.enable = true;
        enable = true;
        extraPortals = with pkgs;
          [xdg-desktop-portal-gtk]
          ++ (
            if wm.primary == "hyprland"
            then [pkgs.xdg-desktop-portal-hyprland]
            else []
          );
        config.common.default = "*";
      };
    };
  };
}
