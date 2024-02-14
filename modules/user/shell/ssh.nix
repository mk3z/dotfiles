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

    # Fablab
    matchBlocks = {
      rtr = {
        hostname = "10.42.0.1";
        user = "root";
      };
      amdahl = {
        hostname = "10.42.0.11";
        user = "root";
      };
      babbage = {
        hostname = "10.42.0.12";
        user = "root";
      };
      carmack = {
        hostname = "10.42.0.13";
        user = "root";
      };
      bastion = {
        hostname = "65.109.234.4";
        user = "root";
      };
    };
  };

  services.ssh-agent.enable = true;
}
