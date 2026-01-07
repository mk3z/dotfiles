{pkgs, ...}: {
  stylix = {
    enable = true;
    image = ../../../files/wallpaper.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    polarity = "dark";
  };
}
