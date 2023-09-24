{ username, homePersistDir, homeDirectory, ... }:
{
  programs.steam.enable = true;
  environment.persistence."${homePersistDir}".directories = [{
    directory = "${homeDirectory}/.local/share/Steam";
    user = username;
    group = "users";
  }];
}
