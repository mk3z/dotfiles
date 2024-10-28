# This file is kind of useless but I will keep it around to preserve uniformity.
{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption;
  cfg = config.mkez.services.ratbag;
in {
  options.mkez.services.ratbag.enable = mkEnableOption "Enable Ratbag";
  config.services.ratbagd.enable = cfg.enable;
}
