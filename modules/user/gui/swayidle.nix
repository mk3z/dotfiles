{
  pkgs,
  config,
  ...
}: let
  inherit (config.mkez.gui.wm) primary;
  inherit (config.mkez.gui.wm.${primary}) screenOn screenOff;
in {
  services.swayidle = {
    enable = true;
    systemdTarget = "graphical-session.target";
    timeouts = [
      {
        timeout = 600;
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
      {
        timeout = 660;
        command = screenOff;
        resumeCommand = screenOn;
      }
    ];
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
    ];
  };

  systemd.user.services.swayidle.Unit.After = ["graphical-session.target"];
}
