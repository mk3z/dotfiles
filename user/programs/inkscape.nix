{
  pkgs,
  homePersistDir,
  homeDirectory,
  ...
}: {
  home = {
    packages = with pkgs; [inkscape];
    persistence."${homePersistDir}${homeDirectory}".directories = [".config/inkscape"];
  };
}
