{ pkgs, ... }:

let terminal = "kitty";
in {
  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;

    settings = {
      exec-once = [
        # set wallpaper
        "${pkgs.swaybg}/bin/swaybg -i ${builtins.toString ../../wallpaper.jpg}"
        # Start polkit agent
        "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1"
      ];

      general = {
        # Don't waste space
        gaps_in = 0;
        gaps_out = 0;
        # The only color that can be seen
        # Sadly stylix does not support Hyprland (yet)
        "col.inactive_border" = "0xff3b4252";
        "col.active_border" = "0xff5e81ac";
      };

      # Don't waste more space
      dwindle.no_gaps_when_only = 1;
      master.no_gaps_when_only = 1;

      # set keyboard layout
      input = {
        kb_model = "pc105";
        # Custom layout set in ./keyboard.nix
        kb_layout = "colemat";
        kb_options = "caps:escape";
        repeat_rate = "50";
        repeat_delay = "300";
      };

      # keybinds
      "$mod" = "SUPER";
      "$mod_shift" = "SUPER_SHIFT";
      "$terminal" = "${pkgs."${terminal}"}/bin/${terminal}";
      "$editor" = "emacsclient -c -a 'emacs'";
      "$menu" = "${pkgs.wofi}/bin/wofi --show drun -I -G";
      "$lock" = "${pkgs.swaylock}/bin/swaylock -f";
      bind = [
        # utility
        "$mod, q, killactive"
        "$mod, l, exec, $lock"
        ## screenshot
        ", PRINT, exec, ${pkgs.slurp}/bin/slurp | ${pkgs.grim}/bin/grim -g - - | ${pkgs.swappy}/bin/swappy -f -"

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

        # Audio
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];

      binde = [
        # Screen brightness
        ", XF86MonBrightnessUp, exec, brillo -q -A 1 -u 100000"
        ", XF86MonBrightnessDown, exec, brillo -q -U 1 -u 100000"

        # Audio
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 1%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"
      ];

      bindl = [
        # Enable and disable laptop screen
        ''
          $mod, p, exec, hyprctl keyword monitor "eDP-1, 2560x1440@165, 0x0, 1.5"''
        ''$mod_shift, p, exec, hyprctl keyword monitor "eDP-1, disable"''
      ];

      # Enable transparency for terminal and emacs
      windowrule =
        "opacity 0.85 override 0.85 override,(${terminal}|(E|e)macs)";
      # Enable blur for waybar
      layerrule = "blur ,waybar";

      # Spares the battery
      decoration.drop_shadow = false;

      misc = {
        # Disable splash
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        # Enable window swallowing
        enable_swallow = true;
        swallow_regex = "^(${terminal})$";
      };

      # Animations
      animations.enabled = false;

      # Disable Xwayland scaling
      xwayland.force_zero_scaling = true;

      # Set laptop screen to maximum refresh rate and appropriate scaling
      # TODO: Maybe make this work with variables so it works on other machines
      monitor = [ "eDP-1, 2560x1440@165, 0x0, 1.5" ];
    };
  };
}
