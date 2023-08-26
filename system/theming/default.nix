{ pkgs, inputs, ... }: {
  fonts = {
    packages = with pkgs; [
      libertinus
      roboto
      (nerdfonts.override { fonts = [ "FiraCode" "NerdFontsSymbolsOnly" ]; })
      symbola
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
    ];
  };

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
        package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
        name = "FiraCode Nerd Font Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      sizes.terminal = 10;
    };
  };
}
