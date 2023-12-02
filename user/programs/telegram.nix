{
  pkgs,
  homePersistDir,
  homeDirectory,
  ...
}: {
  home = {
    packages = with pkgs; [telegram-desktop];
    persistence."${homePersistDir}${homeDirectory}".directories = [".local/share/TelegramDesktop"];
  };
}
