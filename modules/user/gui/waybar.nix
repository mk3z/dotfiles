{
  stylix.targets.waybar.enable = false;

  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      mainBar = {
        position = "bottom";
        height = 20;
        modules-left = ["hyprland/workspaces" "hyprland/window"];
        modules-right = [
          "cpu"
          "memory"
          "bluetooth"
          "network"
          "custom/vpn"
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

        "custom/vpn" = {
          format = "VPN 󰌾";
          exec = "echo '{\"class\": \"connected\"}'";
          exec-if = "test -d /proc/sys/net/ipv4/conf/wg-mullvad";
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
        font-size: 12px;
        min-height: 0;
        border-bottom: none;
        padding: 0;
        margin: 0;
        background-color: rgb(46, 52, 64);
        color: #e5e9f0;
      }

      window#waybar {
        padding: 0;
        margin: 0;
      }

      #clock, #battery, #wireplumber, #network, #custom-vpn, #bluetooth, #cpu, #memory {
        padding-left: 5px;
        padding-right: 5px;
        border-left: 1px solid;
      }

      #window {
        padding: 0 4px;
      }

      #workspaces button {
        padding: 0 0 1px;
        border-radius: 0;
      }

      #workspaces button.active {
        padding: 0;
        border-bottom: 1px solid;
      }
    '';
  };
}
