{ config, pkgs, inputs, ... }:

{

  stylix = {
    base16Scheme = "${inputs.base16}/nord.yaml";
    image = ./wallpaper.jpg;
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
        package = pkgs.terminus_font;
        name = "Terminus";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };

  fonts = {
    fonts = with pkgs; [
      terminus_font
      libertinus
      lmodern
      roboto
      (nerdfonts.override { fonts = [ "FiraCode" "RobotoMono" ]; })
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "Terminus" "FiraCode Nerd Font" ];
        sansSerif = [ "Roboto" ];
        serif = [ "Libertinus Serif" ];
      };
    };
  };

}
