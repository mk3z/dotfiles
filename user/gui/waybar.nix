{
  stylix.targets.waybar.enable = false;

  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      mainBar = {
        position = "bottom";
        height = 20;
        modules-left = [ "hyprland/workspaces" "hyprland/window" ];
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
          format-time = "{H}:{M}";
          format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          format = "{icon} {capacity}% {time} {power:0.2f}W";
        };

        "wireplumber" = {
          interval = 1;
          format = "{icon} {volume}%";
          format-muted = "󰝟";
          format-icons = [ "󰕿" "󰖀" "󰕾" ];
        };

        "bluetooth" = {
          interval = 10;
          format = "󰂯 {status}";
          format-connecte = "󰂯 {device_alias}";
          format-connected-battery =
            "󰥈 {device_alias} {device_battery_percentage}%";
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
          format-ethernet =
            "󰈁 {ipaddr}/{cidr}  {bandwidthUpBits}  {bandwidthDownBits}";
          format-wifi =
            "󰖩 {essid} {frequency}GHz {signalStrength}%  {bandwidthUpBits}  {bandwidthDownBits}";
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

      };
    };

    style = ''
      * {
        font-family: "Monospace";
        font-size: 12px;
        min-height: 0;
        border-bottom: none;
        background-color: rgba(46, 52, 64, 0.57);
        color: #e5e9f0;
      }

      window#waybar {
        padding: 0;
        margin: 0;
      }

      #clock, #battery, #wireplumber, #network, #custom-vpn, #bluetooth, #cpu, #memory {
        margin: 0 4px;
        padding: 0 4px;
        border-bottom: 1px solid;
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
