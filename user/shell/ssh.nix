{
  homePersistDir,
  homeDirectory,
  ...
}: {
  home.persistence."${homePersistDir}${homeDirectory}".directories = [".ssh"];

  programs.ssh = {
    enable = true;
    extraConfig = ''
      AddKeysToAgent yes
    '';
  };

  services.ssh-agent.enable = true;
}
