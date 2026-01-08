{
  osConfig,
  pkgs,
  ...
}: let
  inherit (osConfig.mkez.core) homePersistDir;
in {
  home = {
    packages = [pkgs.signal-desktop];
    persistence."${homePersistDir}".directories = [".config/Signal"];
  };
}
