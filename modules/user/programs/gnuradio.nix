{
  osConfig,
  pkgs,
  ...
}: let
  inherit (osConfig.mkez.core) homePersistDir;
in {
  home = {
    packages = [pkgs.gnuradio];
    persistence."${homePersistDir}".directories = [".gnuradio"];
  };
}
