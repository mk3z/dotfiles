{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.features.syncthing;
in {
  options.features.syncthing.enable = mkEnableOption "Enable Syncthing";
  config = mkIf cfg.enable {
    networking.firewall = {
      allowedTCPPorts = [22000];
      allowedUDPPorts = [22000 21027];
    };
  };
}
