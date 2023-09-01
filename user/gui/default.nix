{ lib, pkgs, ... }:

{
  imports = [
    ./hyprland.nix

    ./keyboard.nix
    ./cursor.nix

    ./gtk.nix

    ./terminal.nix
    ./swaylock.nix
    ./swayidle.nix
    ./waybar.nix
    ./wofi.nix
  ];

  home = {
    packages = with pkgs; [ hyprpicker wdisplays wev wl-clipboard ];

    # Tell programs to use the Ozone backend
    sessionVariables.NIXOS_OZONE_WL = "1";
  };

  # Notification daemon
  services.mako.enable = true;
}
