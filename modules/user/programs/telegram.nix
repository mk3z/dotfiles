{
  osConfig,
  pkgs,
  ...
}: let
  inherit (osConfig.mkez.core) homePersistDir;
  inherit (osConfig.mkez.user) homeDirectory;
in {
  home = {
    packages = with pkgs; [telegram-desktop];
    persistence."${homePersistDir}${homeDirectory}".directories = [".local/share/TelegramDesktop"];
  };
}
