{
  osConfig,
  pkgs,
  ...
}: let
  inherit (osConfig.mkez.core) homePersistDir;
  inherit (osConfig.mkez.user) homeDirectory;
in {
  home = {
    packages = with pkgs; [libreoffice];
    persistence."${homePersistDir}${homeDirectory}".directories = [".config/libreoffice"];
  };
}