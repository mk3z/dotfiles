{
  osConfig,
  pkgs,
  ...
}: let
  inherit (osConfig.mkez.core) homePersistDir;
in {
  home = {
    packages = with pkgs; [telegram-desktop];
    persistence."${homePersistDir}".directories = [".local/share/TelegramDesktop"];
  };
}
