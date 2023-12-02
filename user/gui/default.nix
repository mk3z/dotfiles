{ pkgs, ... }:

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
    ./zathura.nix
  ];

  home = {
    packages = with pkgs; [ hyprpicker wdisplays wev wl-clipboard ];

    sessionVariables = {
      # Tell electron programs to use the Ozone backend
      NIXOS_OZONE_WL = "1";
      # Tell GTK to use the Wayland backend
      GDK_BACKEND = "wayland";
    };
  };

  # Notification daemon
  services.mako = {
    enable = true;
    defaultTimeout = 5000;
  };
}
