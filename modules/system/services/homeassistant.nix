{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.homeassistant;
  tailscaleIntreface = config.services.tailscale.interfaceName;
  inherit (config.mkez.core) hostname;
  port = 8123;
in {
  options.mkez.services.homeassistant.enable = mkEnableOption "Enable Homeassistant";
  config = mkIf cfg.enable {
    services = {
      home-assistant = {
        enable = true;
        lovelaceConfigWritable = true;
        extraComponents = ["zha"];
        customComponents = with pkgs.home-assistant-custom-components; [
          adaptive_lighting
        ];
        extraPackages = python3Packages:
          with python3Packages; [
            numpy
            zeroconf

            zlib-ng
            isal
          ];

        config = {
          http = {
            server_host = "${hostname}.intra.mkez.fi";
            server_port = port;
          };
          homeassistant = {
            name = "Home";
            unit_system = "metric";
            temperature_unit = "C";
          };
        };
      };
    };

    networking.firewall.interfaces.${tailscaleIntreface}.allowedTCPPorts = [port];
  };
}
