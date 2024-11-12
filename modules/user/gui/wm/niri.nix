{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkOption mkIf types;
  cfg = config.mkez.gui.wm.niri;
  terminal = "alacritty";

  inherit (config.programs) niri;
  inherit (config.mkez) gui;

  monitorControl =
    pkgs.writeShellScript "monitor-control"
    ''
      MONITORS=$(${niri.package}/bin/niri msg outputs | ${pkgs.gnugrep}/bin/grep Output | ${pkgs.gnused}/bin/sed 's/\(^[^"]*"\)\|\(".*$\)//g')

      IFS=$'\n'
      for m in $MONITORS; do
        ${niri.package}/bin/niri msg output "$m" "$1"
      done;
    '';
in {
  options.mkez.gui.wm.niri = {
    enable = mkOption {
      type = types.bool;
      default = config.mkez.gui.wm.primary == "niri";
      description = "Whether to enable Niri";
    };
    command = mkOption {
      type = types.str;
      default = "${niri.package}/bin/niri-session";
    };
    screenOff = mkOption {
      type = types.str;
      default = "${monitorControl} off";
    };
    screenOn = mkOption {
      type = types.str;
      default = "${monitorControl} on";
    };
  };

  config = mkIf cfg.enable {
    home = {
      sessionVariables = {
      };
    };

    programs.niri.settings = {
      environment = {
        NIXOS_OZONE_WL = "1";
        XDG_CURRENT_DESKTOP = "niri";
        WLR_BACKEND = "vulkan";

        MOZ_ENABLE_WAYLAND = "1";
        QT_QPA_PLATFORM = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        CLUTTER_BACKEND = "wayland";
        GDK_BACKEND = "wayland";
      };

      prefer-no-csd = true;

      input = {
        keyboard = {
          repeat-delay = 250;
          repeat-rate = 60;

          xkb.layout = "colemat";
        };

        touchpad = {
          dwt = true;
          dwtp = true;
        };

        focus-follows-mouse.enable = true;
        warp-mouse-to-focus = true;
      };

      screenshot-path = "~/Downloads/Screenshots/%Y-%m-%dT%H:%M:%S.png";

      layout = {
        border = {
          enable = true;
          width = 1;
        };

        default-column-width.proportion = 0.5;
        always-center-single-column = true;

        gaps = 0;
      };

      animations.slowdown = 0.5;

      spawn-at-startup = [
        # See https://github.com/YaLTeR/niri/wiki/Xwayland
        {command = ["${lib.getExe pkgs.xwayland-satellite-unstable}" ":25"];}
        {command = ["${pkgs.swaybg}/bin/swaybg" "-m" "fill" "-i" "${builtins.toString osConfig.stylix.image}"];}
      ];

      environment = {
        DISPLAY = ":25";
      };

      binds = let
        playerctl = "${pkgs.playerctl}/bin/playerctl";
        wpctl = "${pkgs.wireplumber}/bin/wpctl";
        launcher = lib.strings.splitString " " gui.launcher.command;
      in
        {
          "Mod+Return".action.spawn = [terminal];
          "Mod+W".action.spawn = ["${pkgs.firefox}/bin/firefox"];
          "Mod+D".action.spawn = launcher;
          "Mod+L".action.spawn = ["${pkgs.swaylock}/bin/swaylock"];

          "Mod+Q".action.close-window = [];
          "Mod+Shift+Q".action.quit = [];

          "Print".action.screenshot = [];
          "Mod+Print".action.screenshot-screen = [];
          "Shift+Print".action.screenshot-window = [];

          # Window management

          "Mod+M".action.focus-column-left-or-last = [];
          "Mod+N".action.focus-window-or-workspace-down = [];
          "Mod+E".action.focus-window-or-workspace-up = [];
          "Mod+I".action.focus-column-right-or-first = [];

          "Mod+Control+M".action.move-column-left = [];
          "Mod+Control+N".action.move-window-down-or-to-workspace-down = [];
          "Mod+Control+E".action.move-window-up-or-to-workspace-up = [];
          "Mod+Control+I".action.move-column-right = [];

          "Mod+G".action.focus-column-first = [];
          "Mod+Shift+G".action.focus-column-last = [];
          "Mod+Tab".action.focus-workspace-previous = [];

          "Mod+Shift+M".action.focus-monitor-left = [];
          "Mod+Shift+N".action.focus-monitor-down = [];
          "Mod+Shift+E".action.focus-monitor-up = [];
          "Mod+Shift+I".action.focus-monitor-right = [];

          "Mod+Shift+Control+M".action.move-window-to-monitor-left = [];
          "Mod+Shift+Control+N".action.move-window-to-monitor-down = [];
          "Mod+Shift+Control+E".action.move-window-to-monitor-up = [];
          "Mod+Shift+Control+I".action.move-window-to-monitor-right = [];

          "Alt+M".action.set-column-width = "-10%";
          "Alt+I".action.set-column-width = "+10%";
          "Alt+E".action.set-window-height = "-10%";
          "Alt+N".action.set-window-height = "+10%";

          "Mod+F".action.maximize-column = [];
          "Mod+Shift+F".action.fullscreen-window = [];

          "Mod+Comma".action.consume-window-into-column = [];
          "Mod+Period".action.expel-window-from-column = [];
          "Mod+Space".action.center-column = [];

          "Mod+Shift+O".action.show-hotkey-overlay = [];

          # Volume

          "XF86AudioMute".action.spawn = [wpctl "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
          "XF86AudioMicMute".action.spawn = [wpctl "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"];
          "XF86AudioRaiseVolume".action.spawn = [wpctl "set-volume" "-l" "1.5" "@DEFAULT_AUDIO_SINK@" "1%+"];
          "XF86AudioLowerVolume".action.spawn = [wpctl "set-volume" "@DEFAULT_AUDIO_SINK@" "1%-"];

          # Brightness

          "XF86MonBrightnessUp".action.spawn = ["brillo" "-q" "-A" "1" "-u 1000"];
          "XF86MonBrightnessDown".action.spawn = ["brillo" "-q" "-U" "1" "-u 1000"];

          # Music player

          "Mod+P".action.spawn = [playerctl "play-pause"];
          "Mod+Left".action.spawn = [playerctl "previous"];
          "Mod+Right".action.spawn = [playerctl "next"];
        }
        // (lib.attrsets.mergeAttrsList (
          map (x: {
            "Mod+${toString x}".action.focus-workspace = x;
            "Mod+Shift+${toString x}".action.move-column-to-workspace = x;
          })
          (builtins.genList (x: x + 1) 9)
        ));
    };
  };
}
