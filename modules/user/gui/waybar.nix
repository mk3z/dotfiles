{osConfig, ...}: let
  inherit (osConfig.services.tailscale) interfaceName;
in {
  stylix.targets.waybar.enable = false;

  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      mainBar = {
        position = "bottom";
        height = 20;
        modules-left = ["hyprland/workspaces" "hyprland/window"];
        modules-right =
          if osConfig.mkez.hardware.bluetooth.enable
          then [
            "tray"
            "cpu"
            "memory"
            "bluetooth"
            "network"
            "custom/mullvad"
            "custom/tailscale"
            "wireplumber"
            "battery"
            "clock"
          ]
          else [
            "tray"
            "cpu"
            "memory"
            "network"
            "custom/mullvad"
            "custom/tailscale"
            "wireplumber"
            "battery"
            "clock"
          ];

        "clock" = {
          interval = 1;
          format = "{:%a %F %T}";
        };

        "battery" = {
          interval = 10;
          format-time = "{H}:{m}";
          format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          format = "{icon} {capacity}% {time} {power:0.2f}W";
        };

        "wireplumber" = {
          interval = 1;
          format = "{icon} {volume}%";
          format-muted = "󰝟";
          format-icons = ["󰕿" "󰖀" "󰕾"];
        };

        "bluetooth" = {
          interval = 10;
          format = "󰂯 {status}";
          format-connected = "󰂯 {device_alias}";
          format-connected-battery = "󰥈 {device_alias} {device_battery_percentage}%";
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
        };

        "custom/mullvad" = {
          format = "mullvad 󰌾";
          exec = "echo '{\"class\": \"connected\"}'";
          exec-if = "test -d /proc/sys/net/ipv4/conf/wg0-mullvad";
          return-type = "json";
          interval = 5;
        };

        "custom/tailscale" = {
          format = "tailscale 󰛳";
          exec = "echo '{\"class\": \"connected\"}'";
          exec-if = "test -d /proc/sys/net/ipv4/conf/${interfaceName}";
          return-type = "json";
          interval = 5;
        };

        "network" = {
          interval = 10;
          format-ethernet = "󰈁 {ipaddr}/{cidr}  {bandwidthUpBits}  {bandwidthDownBits}";
          format-wifi = "󰖩 {essid} {frequency}GHz {signalStrength}%  {bandwidthUpBits}  {bandwidthDownBits}";
          format-disconnected = "disconnected";
        };

        "memory" = {
          interval = 5;
          format = " {percentage}% 󰾴 {swapPercentage}%";
        };

        "cpu" = {
          interval = 5;
          format = " {usage}%";
        };

        "tray" = {
          icon-size = 12;
          spacing = 4;
        };

        "hyprland/workspaces" = {
          "format" = "{icon}";
          "format-icons" = {
            "11" = "1";
            "12" = "2";
            "13" = "3";
            "14" = "4";
            "15" = "5";
            "16" = "6";
            "17" = "7";
            "18" = "8";
            "19" = "9";
            "20" = "10";
            "10" = "10";
            "21" = "1";
            "22" = "2";
            "23" = "3";
            "24" = "4";
            "25" = "5";
            "26" = "6";
            "27" = "7";
            "28" = "8";
            "29" = "9";
            "30" = "10";
            "31" = "1";
            "32" = "2";
            "33" = "3";
            "34" = "4";
            "35" = "5";
            "36" = "6";
            "37" = "7";
            "38" = "8";
            "39" = "9";
            "40" = "10";
          };
        };
      };
    };

    style = ''
      * {
        font-family: "Monospace";
        font-size: 10px;
        min-height: 0;
        padding: 0;
        margin: 0;
        border: 0;
        background-color: @theme_base_color;
        color: @theme_text_color;
      }

      #clock, #battery, #wireplumber, #network, #custom-mullvad, #custom-tailscale, #bluetooth, #memory, #cpu, #tray {
        margin: 0 4px;
        padding: 0 4px;
        border-bottom: 1px solid;
      }

      #window {
        padding: 0 4px;
      }

      #workspaces button.active {
        border-radius: 0;
        border-bottom: 1px solid;
      }
    '';
  };
}
