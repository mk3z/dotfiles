{
  osConfig,
  pkgs,
  ...
}: let
  inherit (osConfig.mkez.core) homePersistDir;
  inherit (osConfig.mkez.user) homeDirectory;
in {
  home = {
    packages = with pkgs; [qbittorrent];
    persistence."${homePersistDir}${homeDirectory}".directories = [
      ".config/qBittorrent"
      ".local/share/qBittorrent"
    ];
  };
}
