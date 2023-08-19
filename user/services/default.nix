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
        timeout = 300;
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
      {
        timeout = 600;
        command = ''swaymsg "output * dpms off"'';
        resumeCommand = ''swaymsg "output * dpms on"'';
      }
    ];
    events = [{
      event = "before-sleep";
      command = "${pkgs.swaylock}/bin/swaylock -f";
    }];
  };
}
