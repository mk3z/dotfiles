{...}: {
  imports = [
    ./hyprland.nix

    ./keyboard.nix
    ./cursor.nix

    ./gtk.nix

    ./kanshi.nix
    ./terminal.nix
    ./swaylock.nix
    ./swayidle.nix
    ./waybar.nix
    ./wofi.nix
    ./zathura.nix
  ];

  # Notification daemon
  services.mako = {
    enable = true;
    defaultTimeout = 5000;
  };
}
