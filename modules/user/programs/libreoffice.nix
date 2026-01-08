{
  osConfig,
  pkgs,
  ...
}: let
  inherit (osConfig.mkez.core) homePersistDir;
in {
  home = {
    packages = [pkgs.libreoffice];
    persistence."${homePersistDir}".directories = [".config/libreoffice"];
  };
}
