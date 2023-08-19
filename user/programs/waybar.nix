{
  enable = true;

  settings = {
    mainBar = {
      position = "bottom";
      height = 16;
      modules-left = [ "hyprland/workspaces" "hyprland/window" ];
      modules-right = [ "network" "battery" "clock" ];

      "clock" = {
        interval = 1;
        format = "{:%a %F %T}";
      };

      "network" = {
        interval = 10;
        format-ethernet = "{ipaddr}/{cidr}";
        format-wifi =
          "{essid} {frequency}GHz {signalStrength}% {ipaddr}/{cidr}";
        format-disconnected = "disconnected";
      };

      "battery" = {
        interval = 10;
        format = "{capacity}% {time}";
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

    #clock, #battery, #network {
      border-left: 1px solid;
      padding: 0 4px;
    }

    #window {
      padding: 0 4px;
    }

    #workspaces button {
      padding: 0;
      border: 1px solid;
      border-radius: 0;
    }
  '';
}
