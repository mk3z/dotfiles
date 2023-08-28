{ pkgs }:

{
  emacs.enable = true;

  mako.enable = true;

  ssh-agent.enable = true;

  swayidle = {
    enable = true;
    systemdTarget = "graphical-session.target";
    timeouts = [
      {
        timeout = 150;
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
      {
        timeout = 300;
        command = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
        resumeCommand = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
      }
    ];
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
    ];
  };
}
