{
  osConfig,
  inputs,
  pkgs,
  ...
}: let
  inherit (osConfig.mkez.core) homePersistDir;
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  home.persistence."${homePersistDir}".directories = [".config/spotify"];

  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      fullAlbumDate
      hidePodcasts
      keyboardShortcut
    ];
  };
}
