{
  osConfig,
  lib,
  pkgs,
  inputs,
  ...
}: let
  terminal = "alacritty";
in {
  imports = [inputs.hyprland.homeManagerModules.default];

  home = {
    packages = with pkgs; [hyprpicker wdisplays wev wl-clipboard];
    sessionVariables = {
      MOZ_ENABLE_WAYLAND = 1;
      QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
      WLR_NO_HARDWARE_CURSORS = 1;
      CLUTTER_BACKEND = "wayland";
      XDG_SESSION_TYPE = "wayland";
      WLR_BACKEND = "vulkan";
      QT_QPA_PLATFORM = "wayland";
      GDK_BACKEND = "wayland";
      NIXOS_OZONE_WL = 1;
    };
  };

  stylix.targets.hyprland.enable = false;

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;

    plugins = [inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces];

    settings = {
      exec-once = [
        # set wallpaper
        "${pkgs.swaybg}/bin/swaybg -m fill -i ${
          builtins.toString osConfig.stylix.image
        }"
        # Start polkit agent
        "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1"
      ];

      general = {
        # Don't waste space
        gaps_in = 0;
        gaps_out = 0;

        cursor_inactive_timeout = 30;

        # The only color that can be seen
        # Sadly stylix does not support Hyprland (yet)
        "col.inactive_border" = lib.mkForce "0xff3b4252";
        "col.active_border" = lib.mkForce "0xff5e81ac";
      };

      # set keyboard layout
      input = {
        kb_model = "pc105";
        # Custom layout set in ./keyboard.nix
        kb_layout = "colemat,us";
        kb_variant = ",colemak";
        kb_options = "caps:escape";
        repeat_rate = "50";
        repeat_delay = "300";
        touchpad.natural_scroll = true;
      };

      # keybinds
      "$mod" = "SUPER";
      "$mod_shift" = "SUPER_SHIFT";
      "$alt" = "ALT";
      "$terminal" = "${pkgs."${terminal}"}/bin/${terminal}";
      "$editor" = "emacsclient -c -a 'emacs'";
      "$menu" = "${pkgs.rofi-wayland}/bin/rofi -show drun";
      "$lock" = "${pkgs.swaylock}/bin/swaylock -f";
      bind = [
        # Utility
        "$mod, q, killactive"
        "$mod, l, exec, $lock"
        ## Screenshot
        ", PRINT, exec, ${pkgs.slurp}/bin/slurp | ${pkgs.grim}/bin/grim -g - - | ${pkgs.swappy}/bin/swappy -f -"

        # Programs
        "$mod, RETURN, exec, $terminal msg create-window || $terminal"
        "$mod, h, exec, $editor"
        "$mod, d, exec, $menu"
        "$mod, w, exec, ${pkgs.firefox}/bin/firefox"

        # Window management
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

        # Workspace management
        "$mod, t, split-workspace, m+1"
        "$mod, s, split-workspace, m-1"
        "$mod, 1, split-workspace, 1"
        "$mod, 2, split-workspace, 2"
        "$mod, 3, split-workspace, 3"
        "$mod, 4, split-workspace, 4"
        "$mod, 5, split-workspace, 5"
        "$mod, 6, split-workspace, 6"
        "$mod, 7, split-workspace, 7"
        "$mod, 8, split-workspace, 8"
        "$mod, 9, split-workspace, 9"
        "$mod, 0, split-workspace, 10"
        "$mod_shift, t, split-movetoworkspacesilent, m+1"
        "$mod_shift, s, split-movetoworkspacesilent, m-1"
        "$mod_shift, 1, split-movetoworkspacesilent, 1"
        "$mod_shift, 2, split-movetoworkspacesilent, 2"
        "$mod_shift, 3, split-movetoworkspacesilent, 3"
        "$mod_shift, 4, split-movetoworkspacesilent, 4"
        "$mod_shift, 5, split-movetoworkspacesilent, 5"
        "$mod_shift, 6, split-movetoworkspacesilent, 6"
        "$mod_shift, 7, split-movetoworkspacesilent, 7"
        "$mod_shift, 8, split-movetoworkspacesilent, 8"
        "$mod_shift, 9, split-movetoworkspacesilent, 9"
        "$mod_shift, 0, split-movetoworkspacesilent, 10"

        # Audio
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];

      binde = [
        # Window resizing
        "$alt, m, resizeactive, -10 0"
        "$alt, n, resizeactive, 0 10"
        "$alt, e, resizeactive, 0 -10"
        "$alt, i, resizeactive, 10 0"

        # Screen brightness
        ", XF86MonBrightnessUp, exec, brillo -q -A 1 -u 100000"
        ", XF86MonBrightnessDown, exec, brillo -q -U 1 -u 100000"

        # Audio
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 1%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"
      ];

      bindm = [
        "$alt, mouse:272, movewindow"
        "$alt, mouse:273, resizewindow"
      ];

      # New window will be on the right
      dwindle.force_split = 2;

      # Spares the battery
      decoration.drop_shadow = false;

      misc = {
        # Disable splash
        disable_hyprland_logo = true;
        disable_splash_rendering = true;

        # Enable window swallowing
        enable_swallow = true;
        swallow_regex = "^(${terminal})$";

        vrr = 1;
      };

      # Animations
      animations.enabled = false;

      # Disable Xwayland scaling
      xwayland.force_zero_scaling = true;

      debug.disable_scale_checks = true;
    };
  };
}
