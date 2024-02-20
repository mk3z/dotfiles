{
  pkgs,
  homePersistDir,
  homeDirectory,
  ...
}: {
  home = {
    persistence."${homePersistDir}${homeDirectory}".directories = [".ssh"];
    packages = [pkgs.mosh];
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };

  services.ssh-agent.enable = true;
}
