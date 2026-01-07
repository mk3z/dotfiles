{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption;
  cfg = config.mkez.services.kanshi;
in {
  options.mkez.services.kanshi.settings = mkOption {};
  config.services.kanshi = {
    enable = true;
    systemdTarget = "graphical-session.target";
    inherit (cfg) settings;
  };
}
