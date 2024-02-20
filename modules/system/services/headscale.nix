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
          dns_config = {
            base_domain = "mkez.fi";
            nameservers = ["9.9.9.9" "1.1.1.1"];
          };
          logtail.enabled = false;
        };
      };

      nginx = {
        enable = true;
        virtualHosts.${domain} = {
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://localhost:${toString config.services.headscale.port}";
            proxyWebsockets = true;
          };
        };
      };
    };

    security.acme = {
      acceptTerms = true;
      defaults.email = "matias.zwinger@protonmail.com";
    };

    networking.firewall.allowedTCPPorts = [80 443];

    environment.systemPackages = [config.services.headscale.package];
  };
}
