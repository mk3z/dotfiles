{osConfig, ...}: let
  inherit (osConfig.mkez.core) homePersistDir;
  inherit (osConfig.mkez.user) homeDirectory;
in {
  services.syncthing.enable = true;
  home = {
    persistence."${homePersistDir}${homeDirectory}".directories = [".config/syncthing"];
  };
}
