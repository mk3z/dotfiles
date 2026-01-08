{osConfig, ...}: let
  inherit (osConfig.mkez.core) homePersistDir;
in {
  services.syncthing.enable = true;
  home = {
    persistence."${homePersistDir}".directories = [".config/syncthing"];
  };
}
