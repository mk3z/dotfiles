{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.flatpak;
  inherit (config.mkez.core) homePersistDir;
  inherit (config.mkez.user) username;
in {
  options.mkez.services.flatpak.enable = mkEnableOption "Enables Flatpak";
  config = mkIf cfg.enable {
    services.flatpak.enable = true;
    environment.persistence.${homePersistDir}.users.${username}.directories = [".local/share/flatpak"];
  };
}
