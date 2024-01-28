{pkgs, ...}: {
  # I REALLY need to package this:
  # https://github.com/simtrami/posy-improved-cursor-linux

  stylix.cursor = {
    package = pkgs.phinger-cursors;
    name = "phinger-cursors";
  };
}
