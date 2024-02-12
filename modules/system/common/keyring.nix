{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf (!config.mkez.core.server) {
    services.gnome.gnome-keyring.enable = true;
    programs.seahorse.enable = true;

    # Allow swaylock to unlock the computer for us
    security.pam.services.swaylock.text = "auth include login";
  };
}
