{
  osConfig,
  pkgs,
  ...
}: let
  inherit (osConfig.mkez.core) homePersistDir;
  inherit (osConfig.mkez.user) homeDirectory;
in {
  home = {
    packages = with pkgs; [signal-desktop];
    persistence."${homePersistDir}${homeDirectory}".directories = [".config/Signal"];
  };
}
