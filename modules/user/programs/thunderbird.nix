{
  config,
  osConfig,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.programs.thunderbird;
  inherit (osConfig.mkez.core) homePersistDir;
  inherit (osConfig.mkez.user) homeDirectory;
in {
  options.mkez.programs.thunderbird.enable = mkEnableOption "Whether to enable Thunderbird";
  config = mkIf cfg.enable {
    home.persistence."${homePersistDir}${homeDirectory}".directories = [".thunderbird"];

    programs.thunderbird = {
      enable = true;
      profiles.default = {
        isDefault = true;
        withExternalGnupg = true;
      };
    };
  };
}
