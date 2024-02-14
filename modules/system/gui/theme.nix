{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf (!config.mkez.core.server) {
    stylix = {
      image = ../../../images/wallpaper.jpg;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
      polarity = "dark";
    };
  };
}
