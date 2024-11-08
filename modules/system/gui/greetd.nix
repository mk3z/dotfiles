{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;

  inherit (config.mkez.user) username;
  inherit (config.home-manager.users.${username}.mkez.gui) wm;

  startCommand = wm.${wm.primary}.command;
in {
  config = mkIf (!config.mkez.core.server) {
    services.greetd = {
      enable = true;
      settings = {
        initial_session = {
          command = wm;
          user = username;
        };
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd ${startCommand} --time --time-format %Y-%m-%d %H:%M:%S% --remember";
          user = username;
        };
      };
    };

    # Unlock default GNOME keyring on login
    security.pam.services.greetd.enableGnomeKeyring = true;
  };
}
