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
      default = "${niri.package}/bin/niri msg output * off";
    };
    screenOn = mkOption {
      type = types.str;
      default = "${niri.package}/bin/niri msg output * on";
    };
  };

  config = mkIf cfg.enable {
    home = {
      sessionVariables = {
        NIXOS_OZONE_WL = "1";
        XDG_CURRENT_DESKTOP = "niri";
      };
    };

    programs.niri.settings = {
      prefer-no-csd = true;

      input = {
        keyboard = {
          repeat-delay = 250;
          repeat-rate = 50;

          xkb = {
            layout = "colemat";
            options = "caps:escape";
          };
        };

        touchpad = {
          dwt = true;
          dwtp = true;
        };

        focus-follows-mouse.enable = true;
        warp-mouse-to-focus = true;
      };

      screenshot-path = "~/Pictures/Screenshots/%Y-%m-%dT%H:%M:%S.png";

      layout = {
        border = {
          enable = true;
          width = 1;
        };

        default-column-width.proportion = 0.5;
        center-focused-column = "on-overflow";
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

          "Mod+M".action.focus-column-left = [];
          "Mod+N".action.focus-window-or-workspace-down = [];
          "Mod+E".action.focus-window-or-workspace-up = [];
          "Mod+I".action.focus-column-right = [];
          "Mod+Tab".action.focus-workspace-previous = [];

          "Mod+Shift+M".action.move-column-left = [];
          "Mod+Shift+N".action.move-window-down-or-to-workspace-down = [];
          "Mod+Shift+E".action.move-window-up-or-to-workspace-up = [];
          "Mod+Shift+I".action.move-column-right = [];

          "Alt+M".action.set-column-width = "-10%";
          "Alt+I".action.set-column-width = "+10%";
          "Alt+N".action.set-window-height = "-10%";
          "Alt+E".action.set-window-height = "+10%";

          "Mod+F".action.maximize-column = [];
          "Mod+Shift+F".action.fullscreen-window = [];

          "Mod+Comma".action.consume-window-into-column = [];
          "Mod+Period".action.expel-window-from-column = [];
          "Mod+C".action.center-column = [];

          # Monitor management

          "Mod+R".action.focus-monitor-left = [];
          "Mod+S".action.focus-monitor-up = [];
          "Mod+T".action.focus-monitor-down = [];
          "Mod+G".action.focus-monitor-right = [];

          "Mod+Shift+R".action.move-column-to-monitor-left = [];
          "Mod+Shift+S".action.move-column-to-monitor-up = [];
          "Mod+Shift+T".action.move-column-to-monitor-down = [];
          "Mod+Shift+G".action.move-column-to-monitor-right = [];

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
