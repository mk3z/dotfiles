{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.programs.llm-jail;
in {
  options.mkez.programs.llm-jail.enable = mkEnableOption "LLM Jail sandboxing";

  config = mkIf cfg.enable {
    home.packages = [
      inputs.llm-jail.packages.${pkgs.system}.claude
      inputs.llm-jail.packages.${pkgs.system}.codex
    ];
  };
}
