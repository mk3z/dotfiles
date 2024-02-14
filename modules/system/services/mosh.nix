{
  lib,
  config,
  ...
}: let
  inherit (lib) types mkOption mkIf;
  cfg = config.mkez.services.mosh;
in {
  options.mkez.services.mosh.enable = mkOption {
    default = config.mkez.services.ssh.enable;
    type = types.bool;
    description = "Whether to enable mosh";
  };
  config = mkIf cfg.enable {programs.mosh.enable = true;};
}
