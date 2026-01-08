{
  osConfig,
  pkgs,
  ...
}: let
  inherit (osConfig.mkez.core) homePersistDir;
in {
  home = {
    packages = [pkgs.wineWowPackages.waylandFull];
    persistence."${homePersistDir}".directories = [".wine"];
  };
}
