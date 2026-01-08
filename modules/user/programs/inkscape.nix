{
  osConfig,
  pkgs,
  ...
}: let
  inherit (osConfig.mkez.core) homePersistDir;
in {
  home = {
    packages = with pkgs; [inkscape];
    persistence."${homePersistDir}".directories = [".config/inkscape"];
  };
}
