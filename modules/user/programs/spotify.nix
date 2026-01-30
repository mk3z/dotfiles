{
  lib,
  config,
  osConfig,
  inputs,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  inherit (osConfig.mkez.core) homePersistDir;
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  cfg = config.mkez.programs.spotify;
in {
  options.mkez.programs.spotify.enable = mkEnableOption "Spotify";

  imports = [inputs.spicetify-nix.homeManagerModules.default];

  config = mkIf cfg.enable {
    home.persistence."${homePersistDir}".directories = [".config/spotify"];

    programs.spicetify = {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        fullAlbumDate
        hidePodcasts
        keyboardShortcut
      ];
    };
  };
}
