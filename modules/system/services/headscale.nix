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
          prefixes.v4 = "100.99.0.0/16";
          dns = {
            base_domain = "intra.mkez.fi";
            nameservers.global = ["9.9.9.9" "1.1.1.1"];
            username_in_magic_dns = false;
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

    networking.firewall.allowedTCPPorts = [80 443];

    environment.systemPackages = [config.services.headscale.package];
  };
}
