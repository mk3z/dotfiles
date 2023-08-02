{ pkgs, lib, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
    settings = {
      # set wallpaper
      exec-once = [
        "${pkgs.swaybg}/bin/swaybg -i ${builtins.toString ./wallpaper.jpg}"
        "${pkgs.waybar}/bin/waybar"
      ];

      # general settings
      general = {
        gaps_in = 0;
        gaps_out = 0;
      };

      # set keyboard layout
      input = {
        kb_model = "pc105";
        kb_layout = "colemat";
        repeat_rate = "50";
        repeat_delay = "300";
      };

      # keybinds
      "$mod" = "SUPER";
      "$terminal" = "${pkgs.foot}/bin/foot";
      "$menu" = "${pkgs.wofi}/bin/wofi --show run";
      "$lock" = "${pkgs.swaylock}/bin/swaylock";
      bind = [
        # utility
        "$mod, q, killactive"
        "$mod, l, exec, $lock"

        # programs
        "$mod, RETURN, exec, $terminal"
        "$mod, d, exec, $menu"

        # window management
        "$mod, m, movefocus, l"
        "$mod, n, movefocus, d"
        "$mod, e, movefocus, u"
        "$mod, i, movefocus, r"

        # workspace management
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        "$mod, Shift+1, movetoworkspacesilent, 1"
        "$mod, Shift+2, movetoworkspacesilent, 2"
        "$mod, Shift+3, movetoworkspacesilent, 3"
        "$mod, Shift+4, movetoworkspacesilent, 4"
        "$mod, Shift+5, movetoworkspacesilent, 5"
        "$mod, Shift+6, movetoworkspacesilent, 6"
        "$mod, Shift+7, movetoworkspacesilent, 7"
        "$mod, Shift+8, movetoworkspacesilent, 8"
        "$mod, Shift+9, movetoworkspacesilent, 9"
        "$mod, Shift+0, movetoworkspacesilent, 10"

      ];

      windowrule = "opacity 0.85 override 0.85 override, foot";

      # Animations
      animations.enabled = false;
    };
  };

  home.pointerCursor = {
    package = pkgs.phinger-cursors;
    name = "phinger-cursors";
    x11 = {
      enable = true;
      defaultCursor = "phinger-cursors";
    };
  };

  home.file.".xkb/symbols/colemat" = {
    recursive = true;
    text = ''
      default partial alphanumeric_keys modifier_keys keypad_keys
      xkb_symbols {
        include "us(colemak_dh_iso)"
        replace key <AB05> { [ BackSpace ] };
      };
    '';
  };

}
