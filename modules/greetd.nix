{
  pkgs,
  username,
  ...
}: let
  wm = "${pkgs.hyprland}/bin/Hyprland";
in {
  services.greetd = {
    enable = true;
    settings = rec {
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
}
