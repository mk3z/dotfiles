{pkgs, ...}: {
  stylix.cursor = {
    package = pkgs.posy-cursors;
    name = "Posy_Cursor_Black";
    # TODO: remove when https://github.com/nix-community/stylix/pull/1401 is merged
    size = 32;
  };
}
