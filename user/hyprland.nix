{ pkgs, lib, ... }:

let
  terminal = "kitty"; in
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
    settings = {
      # set wallpaper
      exec-once = [
        "${pkgs.swaybg}/bin/swaybg -i ${builtins.toString ../wallpaper.jpg}"
        "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1"
      ];

      # general settings
      general = {
        gaps_in = 0;
        gaps_out = 0;
        "col.inactive_border" = "0xff3b4252";
        "col.active_border" = "0xff5e81ac";
      };

      dwindle.no_gaps_when_only = 1;
      master.no_gaps_when_only = 1;

      # set keyboard layout
      input = {
        kb_model = "pc105";
        kb_layout = "colemat";
        kb_options = "caps:escape";
        repeat_rate = "50";
        repeat_delay = "300";
      };

      # keybinds
      "$mod" = "SUPER";
      "$mod_shift" = "SUPER_SHIFT";
      "$terminal" = ''${pkgs."${terminal}"}/bin/${terminal}'';
      "$editor" = "emacsclient -c -a 'emacs'";
      "$menu" = "${pkgs.wofi}/bin/wofi --show run";
      "$lock" = "${pkgs.swaylock}/bin/swaylock";
      bind = [
        # utility
        "$mod, q, killactive"
        "$mod, l, exec, $lock"

        # programs
        "$mod, RETURN, exec, $terminal"
        "$mod, h, exec, $editor"
        "$mod, d, exec, $menu"
        "$mod, w, exec, ${pkgs.firefox}/bin/firefox"

        # window management
        "$mod, m, movefocus, l"
        "$mod, n, movefocus, d"
        "$mod, e, movefocus, u"
        "$mod, i, movefocus, r"
        "$mod_shift, m, movewindow, l"
        "$mod_shift, n, movewindow, d"
        "$mod_shift, e, movewindow, u"
        "$mod_shift, i, movewindow, r"
        "$mod_shift, SPACE, togglefloating"
        "$mod, f, fullscreen"

        # workspace management
        "$mod, t, workspace, e+1"
        "$mod, s, workspace, e-1"
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
        "$mod_shift, t, movetoworkspacesilent, e+1"
        "$mod_shift, s, movetoworkspacesilent, e-1"
        "$mod_shift, 1, movetoworkspacesilent, 1"
        "$mod_shift, 2, movetoworkspacesilent, 2"
        "$mod_shift, 3, movetoworkspacesilent, 3"
        "$mod_shift, 4, movetoworkspacesilent, 4"
        "$mod_shift, 5, movetoworkspacesilent, 5"
        "$mod_shift, 6, movetoworkspacesilent, 6"
        "$mod_shift, 7, movetoworkspacesilent, 7"
        "$mod_shift, 8, movetoworkspacesilent, 8"
        "$mod_shift, 9, movetoworkspacesilent, 9"
        "$mod_shift, 0, movetoworkspacesilent, 10"
      ];

      windowrule = "opacity 0.85 override 0.85 override,(${terminal}|Emacs)";
      decoration.drop_shadow = false;

      # Animations
      animations.enabled = false;

      # Disable Xwayland scaling
      xwayland.force_zero_scaling = true;

      monitor = [ "eDP-1, 2560x1440@165, 0x0, 1.5" ];
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

  # Custom keyboard layout based on Colemak-DH ISO
  # replaces the backslash key with backspace
  # and number sign with backslash and pipe
  home.file.".xkb/symbols/colemat" = {
    recursive = true;
    text = ''
      xkb_symbols {
        include "us(colemak_dh_iso)"
        replace key <AB05> { [ BackSpace ] };
        replace key <AC12> { [ backslash, bar ] };
      };
    '';
  };
}
