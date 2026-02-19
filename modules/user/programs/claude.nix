{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.programs.claude;
  inherit (osConfig.mkez.core) homePersistDir;
in {
  options.mkez.programs.claude.enable = mkEnableOption "Claude Code";
  config = mkIf cfg.enable {
    home.persistence."${homePersistDir}".directories = [".claude"];

    programs.claude-code.enable = true;
    home.packages = [pkgs.claude-monitor];
  };
}
