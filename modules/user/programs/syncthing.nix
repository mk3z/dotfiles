{
  homePersistDir,
  homeDirectory,
  ...
}: {
  services.syncthing.enable = true;
  home = {
    persistence."${homePersistDir}${homeDirectory}".directories = [".config/syncthing"];
  };
}
