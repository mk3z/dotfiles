{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.navidrome;
  inherit (config.services.tailscale) interfaceName;
  inherit (config.mkez.core) hostname;
  inherit (config.services.navidrome.settings) Port BaseURL;
in {
  options.mkez.services.navidrome.enable = mkEnableOption "Whether to enable the Navidrome server";
  config = mkIf cfg.enable {
    services = {
      navidrome = {
        enable = true;
        settings = {
          Address = "0.0.0.0";
          Port = 4533;
          BaseURL = "/music";

          MusicFolder = "/media/music";
          DataFolder = "/var/lib/navidrome";
        };
      };

      nginx = {
        enable = true;
        virtualHosts."${hostname}.intra.mkez.fi".locations.${BaseURL}.proxyPass = "http://localhost:${toString Port}";
      };
    };
    networking.firewall.interfaces.${interfaceName}.allowedTCPPorts = [Port 80 443];
  };
}
