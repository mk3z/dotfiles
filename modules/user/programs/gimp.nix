{
  pkgs,
  homePersistDir,
  homeDirectory,
  ...
}: {
  home = {
    packages = with pkgs; [gimp];
    persistence."${homePersistDir}${homeDirectory}".directories = [".config/GIMP"];
  };
}
