{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf (!config.mkez.core.server) {
    fonts = {
      packages = with pkgs; [
        libertinus
        roboto
        (nerdfonts.override {fonts = ["Iosevka" "NerdFontsSymbolsOnly"];})
        symbola
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        fira-code
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

        sizes.terminal = 12;
      };
    };
  };
}
