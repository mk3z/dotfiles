{
  enable = true;

  settings = {
    mainBar = {
      position = "bottom";
      height = 16;
      modules-left = [ "hyprland/workspaces" "hyprland/window" ];
      modules-right = [ "bluetooth" "network" "wireplumber" "battery" "clock" ];

      "clock" = {
        interval = 1;
        format = "{:%a %F %T}";
      };

      "battery" = {
        interval = 10;
        format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        format = "{icon} {capacity}% {time}";
      };

      "wireplumber" = {
        interval = 1;
        format = "{icon} {volume}%";
        format-muted = "󰝟";
        format-icons = [ "󰕿" "󰖀" "󰕾" ];
      };

      "network" = {
        interval = 10;
        format-ethernet = "󰈁 {ipaddr}/{cidr}";
        format-wifi =
          "󰖩 {essid} {frequency}GHz {signalStrength}% {ipaddr}/{cidr}";
        format-disconnected = "disconnected";
      };

      "bluetooth" = {
        interval = 10;
        format = "󰂯 {status}";
        format-connecte = "󰂯 {device_alias}";
        format-connected-battery =
          "󰥈 {device_alias} {device_battery_percentage}%";
      };

    };
  };

  style = ''
    * {
      font-family: "Monospace";
      font-size: 12px;
      opacity: 0.85;
      min-height: 0;
      border-bottom: none;
    }

    window#waybar {
      padding: 0;
      margin: 0;
    }

    #clock, #battery, #wireplumber, #network, #bluetooth {
      margin: 0 4px;
      padding: 0 4px;
      border-bottom: 1px solid;
    }

    #window {
      padding: 0 4px;
    }

    #workspaces button {
      padding: 0;
      border-radius: 0;
    }

    #workspaces button.active {
      border-bottom: 1px solid;
    }
  '';
}
