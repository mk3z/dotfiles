{ pkgs, homePersistDir, homeDirectory, ... }:
{
  home = {
    packages = with pkgs; [ signal-desktop ];
    persistence."${homePersistDir}${homeDirectory}".directories = [ ".config/Signal" ];
  };
}
