{ pkgs, lib, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    systemdIntegration = true;
    wrapperFeatures.gtk = true;

    config = rec {

      modifier = "Mod4";

      keybindings = let
        left = "m";
        down = "n";
        up = "e";
        right = "i";
      in lib.mkOptionDefault {
        "${modifier}+d" = "exec ${menu}";

        "${modifier}+${left}" = "focus left";
        "${modifier}+${down}" = "focus down";
        "${modifier}+${up}" = "focus up";
        "${modifier}+${right}" = "focus right";

        "${modifier}+Shift+${left}" = "move left";
        "${modifier}+Shift+${down}" = "move down";
        "${modifier}+Shift+${up}" = "move up";
        "${modifier}+Shift+${right}" = "move right";

        "${modifier}+h" = "splith";
        "${modifier}+v" = "splitv";
        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+p" = "focus parent";

        "${modifier}+g" = "layout stacking";
        "${modifier}+t" = "layout tabbed";
        "${modifier}+s" = "layout toggle split";

        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+backspace" =
          "exec swaynag -t warning -m 'Do you want to exit sway?' -b 'Yes' 'swaymsg exit'";

        "${modifier}+r" = "mode resize";
      };

      modes = let
        left = "m";
        down = "n";
        up = "e";
        right = "i";
      in lib.mkOptionDefault {
        resize = {
          "${left}" = "resize shrink width 10 px";
          "${down}" = "resize grow height 10 px";
          "${up}" = "resize shrink height 10 px";
          "${right}" = "resize grow width 10 px";
        };
      };

      window.border = 1;

      terminal = "foot";
      menu = "wofi --show run";
      bars = [];

      input = {
        "type:keyboard" = {
          xkb_model = "pc105";
          xkb_layout = "matias";
          repeat_delay = "300";
          repeat_rate = "50";
        };
      };

      seat = {
        "*" = {
          hide_cursor = "5000";
        };
      };

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

}
