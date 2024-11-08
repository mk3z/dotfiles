{osConfig, ...}: let
  inherit (osConfig.mkez.core) homePersistDir;
  inherit (osConfig.mkez.user) homeDirectory;
in {
  home.persistence."${homePersistDir}${homeDirectory}".directories = [".stack"];
}
