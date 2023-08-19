{ config, pkgs, inputs, ... }:

{
  stylix = {
    base16Scheme = "${inputs.base16}/nord.yaml";
    image = ../../wallpaper.jpg;
    fonts = {
      serif = {
        package = pkgs.libertinus;
        name = "Libertinus Serif";
      };

      sansSerif = {
        package = pkgs.roboto;
        name = "Roboto";
      };

      monospace = {
        package = (pkgs.nerdfonts.override { fonts = [ "VictorMono" ]; });
        name = "VictorMono Nerd Font Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
