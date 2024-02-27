{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  wm = "${inputs.hyprland.packages.${pkgs.system}.default}/bin/Hyprland";
  inherit (lib) mkIf;
  inherit (config.mkez.user) username;
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
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd ${wm} --time --time-format %Y-%m-%d %H:%M:%S% --remember";
          user = username;
        };
      };
    };

    # Unlock default GNOME keyring on login
    security.pam.services.greetd.enableGnomeKeyring = true;
  };
}
