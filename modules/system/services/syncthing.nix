{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.syncthing;
in {
  options.mkez.services.syncthing.enable = mkEnableOption "Enable Syncthing";
  config = mkIf cfg.enable {
    networking.firewall = {
      allowedTCPPorts = [22000];
      allowedUDPPorts = [22000 21027];
    };
  };
}
