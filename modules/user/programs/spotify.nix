{
  osConfig,
  inputs,
  pkgs,
  ...
}: let
  inherit (osConfig.mkez.core) homePersistDir;
  inherit (osConfig.mkez.user) homeDirectory;
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  home.persistence."${homePersistDir}${homeDirectory}".directories = [".config/spotify"];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.nord;
    colorScheme = "Nord";
    enabledExtensions = with spicePkgs.extensions; [
      fullAlbumDate
      hidePodcasts
      keyboardShortcut
    ];
  };
}
