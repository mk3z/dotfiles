{osConfig, ...}: let
  inherit (osConfig.mkez.core) homePersistDir;
in {
  home.persistence."${homePersistDir}".directories = [".stack"];
}
