{ pkgs, ... }: {
  # I REALLY need to package this:
  # https://github.com/simtrami/posy-improved-cursor-linux
  home.pointerCursor = {
    package = pkgs.phinger-cursors;
    name = "phinger-cursors";
    gtk.enable = true;
    x11 = {
      enable = true;
      defaultCursor = "phinger-cursors";
    };
  };
}
