{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.headscale;
  domain = "vpn.mkez.fi";
in {
  options.mkez.services.headscale.enable = mkEnableOption "Whether to enable the headscale server";
  config = mkIf cfg.enable {
    services = {
      headscale = {
        enable = true;
        address = "0.0.0.0";
        port = 8080;
        settings = {
          server_url = "https://${domain}";
          ip_prefixes = ["100.99.0.0/16"];
          logtail.enabled = false;
        };
      };

      nginx.virtualHosts.${domain} = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://localhost:${toString config.services.headscale.port}";
          proxyWebsockets = true;
        };
      };
    };

    networking.firewall.allowedTCPPorts = [80 443];

    environment.systemPackages = [config.services.headscale.package];
  };
}
