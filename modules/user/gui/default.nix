{...}: {
  imports = [
    ./wm
    ./launcher

    ./keyboard.nix
    ./cursor.nix

    ./gtk.nix

    ./gammastep.nix
    ./kanshi.nix
    ./terminal.nix
    ./swaylock.nix
    ./swayidle.nix
    ./waybar.nix
    ./swaync.nix
  ];
}
