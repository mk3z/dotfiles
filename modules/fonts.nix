{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      libertinus
      roboto
      (nerdfonts.override {fonts = ["Iosevka" "NerdFontsSymbolsOnly"];})
      symbola
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
    ];
  };

  stylix = {
    fonts = {
      serif = {
        package = pkgs.libertinus;
        name = "Libertinus Serif";
      };

      sansSerif = {
        package = pkgs.maple-mono-NF;
        name = "Maple Mono NF";
      };

      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["Iosevka"];};
        name = "Iosevka Nerd Font Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      sizes.terminal = 10;
    };
  };
}
