{
  config,
  osConfig,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.programs.thunderbird;
  inherit (osConfig.mkez.core) homePersistDir;
in {
  options.mkez.programs.thunderbird.enable = mkEnableOption "Whether to enable Thunderbird";
  config = mkIf cfg.enable {
    home.persistence."${homePersistDir}".directories = [".thunderbird"];

    programs.thunderbird = {
      enable = true;
      profiles.default = {
        isDefault = true;
        withExternalGnupg = true;
      };
    };
  };
}
