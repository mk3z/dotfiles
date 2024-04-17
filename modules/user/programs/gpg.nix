{osConfig, ...}: let
  inherit (osConfig.mkez.core) homePersistDir;
  inherit (osConfig.mkez.user) homeDirectory;
in {
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "curses";
  };
  home.persistence."${homePersistDir}${homeDirectory}".directories = [".gnupg"];
}
