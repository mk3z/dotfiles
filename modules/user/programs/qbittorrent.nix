{
  osConfig,
  pkgs,
  ...
}: let
  inherit (osConfig.mkez.core) homePersistDir;
in {
  home = {
    packages = [pkgs.qbittorrent];
    persistence."${homePersistDir}".directories = [
      ".config/qBittorrent"
      ".local/share/qBittorrent"
    ];
  };
}
