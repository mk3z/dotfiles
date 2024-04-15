{
  osConfig,
  pkgs,
  ...
}: let
  inherit (osConfig.mkez.core) homePersistDir;
  inherit (osConfig.mkez.user) homeDirectory;
in {
  home = {
    packages = with pkgs; [wineWowPackages.waylandFull];
    persistence."${homePersistDir}${homeDirectory}".directories = [".wine"];
  };
}
