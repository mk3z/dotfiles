{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.syncthing;
  guiPort = 8384;
  inherit (config.services.tailscale) interfaceName;
in {
  options.mkez.services.syncthing.enable = mkEnableOption "Enable Syncthing";
  config =
    mkIf cfg.enable {
      networking.firewall = {
        allowedTCPPorts = [22000];
        allowedUDPPorts = [22000 21027];
      };
    }
    // mkIf config.mkez.core.server {
      services.syncthing = {
        enable = true;
        guiAddress = "0.0.0.0:${toString guiPort}";
      };
      networking.firewall.interfaces.${interfaceName}.allowedTCPPorts = [guiPort];
    };
}
