{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.radicale;
  port = 5232;
  inherit (config.mkez.core) hostname;
  inherit (config.services.tailscale) interfaceName;
in {
  options.mkez.services.radicale.enable = mkEnableOption "Enable the Radicale CalDAV";
  config = mkIf cfg.enable {
    age.secrets.radicale_passwd = {
      file = ../../../secrets/htpasswd.age;
      owner = "radicale";
      group = "radicale";
    };

    services = {
      radicale = {
        enable = true;
        settings = {
          server.hosts = ["0.0.0.0:${toString port}"];
          storage.filesystem_folder = "/state/radicale";
          auth = {
            type = "htpasswd";
            htpasswd_filename = config.age.secrets.radicale_passwd.path;
            htpasswd_encryption = "bcrypt";
          };
        };
        rights = {
          root = {
            user = ".+";
            collection = "";
            permissions = "R";
          };
          principal = {
            user = ".+";
            collection = "{user}";
            permissions = "RW";
          };
          calendars = {
            user = ".+";
            collection = "{user}/[^/]+";
            permissions = "rw";
          };
        };
      };

      nginx = {
        enable = true;

        recommendedGzipSettings = true;
        recommendedOptimisation = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;

        virtualHosts."${hostname}.intra.mkez.fi".locations."/caldav/" = {
          proxyPass = "http://localhost:${toString port}/";
          extraConfig = ''
            proxy_set_header X-Script-Name /caldav;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_pass_header Authorization;
          '';
        };
      };
    };

    networking.firewall.interfaces.${interfaceName}.allowedTCPPorts = [80 433];
  };
}
