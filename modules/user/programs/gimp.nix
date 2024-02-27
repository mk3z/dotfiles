{
  osConfig,
  pkgs,
  ...
}: let
  inherit (osConfig.mkez.core) homePersistDir;
  inherit (osConfig.mkez.user) homeDirectory;
in {
  home = {
    packages = with pkgs; [gimp];
    persistence."${homePersistDir}${homeDirectory}".directories = [".config/GIMP"];
  };
}
