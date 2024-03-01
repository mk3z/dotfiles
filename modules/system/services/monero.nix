{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.monero;
  inherit (config.services.tailscale) interfaceName;
  inherit (config.services.monero.rpc) port;
in {
  options.mkez.services.monero.enable = mkEnableOption "Enable Monero daemon";

  config = mkIf cfg.enable {
    services.monero = {
      enable = true;
      mining.enable = false;
      rpc.address = "0.0.0.0";
      dataDir = "/state/monero";
      extraConfig = "confirm-external-bind=1";
    };

    networking.firewall.interfaces.${interfaceName}.allowedTCPPorts = [port];
  };
}
