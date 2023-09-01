{ config, lib, pkgs, ... }:

{
  # I REALLY need to package this:
  # https://github.com/simtrami/posy-improved-cursor-linux
  home.pointerCursor = {
    package = pkgs.capitaine-cursors-themed;
    name = "Capitaine Cursors (Nord)";
    gtk.enable = true;
    x11 = {
      enable = true;
      defaultCursor = "Capitaine Cursors (Nord)";
    };
  };
}
