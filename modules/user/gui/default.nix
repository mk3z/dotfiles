{...}: {
  imports = [
    ./hyprland.nix

    ./keyboard.nix
    ./cursor.nix

    ./gtk.nix

    ./gammastep.nix
    ./kanshi.nix
    ./terminal.nix
    ./swaylock.nix
    ./swayidle.nix
    ./waybar.nix
    ./rofi.nix
  ];

  # Notification daemon
  services.mako = {
    enable = true;
    defaultTimeout = 5000;
  };
}
