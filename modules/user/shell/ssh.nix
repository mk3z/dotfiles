{
  osConfig,
  pkgs,
  ...
}: let
  inherit (osConfig.mkez.core) homePersistDir;
  inherit (osConfig.mkez.user) homeDirectory;
in {
  home = {
    persistence."${homePersistDir}${homeDirectory}".directories = [".ssh"];
    packages = [pkgs.mosh];
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      nas = {
        forwardAgent = true;
      };
    };
  };

  services.ssh-agent.enable = true;
}
