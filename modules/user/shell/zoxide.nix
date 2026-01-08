{osConfig, ...}: let
  inherit (osConfig.mkez.core) homePersistDir;
in {
  home.persistence."${homePersistDir}" = {
    directories = [".local/share/zoxide"];
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
