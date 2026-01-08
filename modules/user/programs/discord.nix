{
  osConfig,
  pkgs,
  ...
}: let
  inherit (osConfig.mkez.core) homePersistDir;
in {
  home = {
    packages = [pkgs.vesktop];
    persistence."${homePersistDir}".directories = [".config/vesktop"];
  };
}
