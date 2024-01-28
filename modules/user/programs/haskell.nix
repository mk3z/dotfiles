{
  homePersistDir,
  homeDirectory,
  ...
}: {
  home.persistence."${homePersistDir}${homeDirectory}".directories = [".stack"];
}
