{
  osConfig,
  inputs,
  pkgs,
  ...
}: let
  inherit (osConfig.mkez.core) homePersistDir;
  inherit (osConfig.mkez.user) homeDirectory;
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in {
  imports = [inputs.spicetify-nix.homeManagerModule];

  home.persistence."${homePersistDir}${homeDirectory}".directories = [".config/spotify"];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.Nord;
    colorScheme = "Nord";
  };
}
