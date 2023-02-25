{ config, lib, pkgs, username, ... }:

{
  services = {
    # greetd login manager
    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${pkgs.sway}/bin/sway";
          user = username;
        };
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd sway --time --time-format %Y-%m-%d %H:%M:%S% --remember";
          user = username;
        };
      };
    };

    # OpenSSH for VM access
    # TODO remove
    openssh = {
      enable = true;
      permitRootLogin = "yes";
    };
  };
}
