{
  pkgs,
  homePersistDir,
  homeDirectory,
  ...
}: {
  home = {
    packages = with pkgs; [qbittorrent];
    persistence."${homePersistDir}${homeDirectory}".directories = [
      ".config/qBittorrent"
      ".local/share/qBittorrent"
    ];
  };
}
