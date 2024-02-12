{
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;

  # Allow swaylock to unlock the computer for us
  security.pam.services.swaylock.text = "auth include login";
}
