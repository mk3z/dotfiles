{pkgs, ...}: {
  stylix = {
    image = ../../../images/wallpaper.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    polarity = "dark";
  };
}
