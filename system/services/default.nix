{ config, lib, pkgs, username, ... }:

let wm = "${pkgs.hyprland}/bin/Hyprland";
in {
  services = {
    # greetd login manager
    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = wm;
          user = username;
        };
        default_session = {
          command =
            "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd ${wm} --time --time-format %Y-%m-%d %H:%M:%S% --remember";
          user = username;
        };
      };
    };

    # OpenSSH for VM access
    # TODO remove
    openssh = {
      enable = true;
      settings = { PermitRootLogin = "yes"; };
    };
  };
}
