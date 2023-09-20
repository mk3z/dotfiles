{ pkgs, homePersistDir, homeDirectory, ... }:
{
  home = {
    packages = with pkgs; [ webcord ];
    persistence."${homePersistDir}${homeDirectory}".directories = [ ".config/WebCord" ];
  };
}
