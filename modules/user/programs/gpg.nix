{
  osConfig,
  pkgs,
  ...
}: let
  inherit (osConfig.mkez.core) homePersistDir;
  inherit (osConfig.mkez.user) homeDirectory;
in {
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    enableSshSupport = osConfig.mkez.features.yubikey.enable;
    pinentryPackage = pkgs.pinentry-curses;
  };
  home.persistence."${homePersistDir}${homeDirectory}".directories = [".gnupg"];
}
