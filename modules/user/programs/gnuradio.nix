{
  osConfig,
  pkgs,
  ...
}: let
  inherit (osConfig.mkez.core) homePersistDir;
  inherit (osConfig.mkez.user) homeDirectory;
in {
  home = {
    packages = with pkgs; [gnuradio];
    persistence."${homePersistDir}${homeDirectory}".directories = [".gnuradio"];
  };
}
