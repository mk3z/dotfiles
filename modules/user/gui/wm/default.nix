{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkOption types;
in {
  options.mkez.gui.wm.primary = mkOption {
    type = types.enum ["hyprland" "niri"];
  };

  imports = [./hyprland.nix];

  config.home.packages = with pkgs; [hyprpicker wdisplays wev wl-clipboard];
}
