{
  osConfig,
  pkgs,
  ...
}: let
  inherit (osConfig.mkez.core) homePersistDir;
in {
  home = {
    packages = with pkgs; [gimp];
    persistence."${homePersistDir}".directories = [".config/GIMP"];
  };
}
