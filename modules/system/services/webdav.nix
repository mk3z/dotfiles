{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.webdav;
  port = 4918;
  inherit (config.mkez.core) hostname;
  inherit (config.services.tailscale) interfaceName;
in {
  options.mkez.services.webdav.enable = mkEnableOption "Enable WebDAV";
  config = mkIf cfg.enable {
    age.secrets.webdav_passwd = {
      file = ../../../secrets/htpasswd.age;
      owner = config.services.nginx.user;
      inherit (config.services.nginx) group;
    };

    services = {
      webdav = {
        enable = true;
        settings = {
          address = "0.0.0.0";
          inherit port;
          debug = true;
          scope = "/state/webdav";
          prefix = "/webdav";
          modify = true;
          auth = false;
          log.outputs = ["stderr" "sdout"];
        };
      };

      nginx = {
        enable = true;

        recommendedGzipSettings = true;
        recommendedOptimisation = true;
        recommendedTlsSettings = true;

        virtualHosts."${hostname}.intra.mkez.fi".locations."/webdav" = {
          proxyPass = "http://localhost:${toString port}/";
          basicAuthFile = config.age.secrets.webdav_passwd.path;
          extraConfig = ''
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header REMOTE-HOST $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Host $host;
            proxy_redirect off;
          '';
        };
      };
    };

    systemd.services.nginx.serviceConfig.ReadWritePaths = ["/state/webdav" "/state/cache"];

    networking.firewall.interfaces.${interfaceName}.allowedTCPPorts = [80 433];
  };
}
