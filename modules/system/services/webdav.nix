{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.webdav;
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

    services.nginx = {
      enable = true;
      virtualHosts."${hostname}.intra.mkez.fi".locations."/webdav/" = {
        alias = "/state/webdav/";
        basicAuthFile = config.age.secrets.webdav_passwd.path;
        extraConfig = ''
          dav_methods PUT DELETE MKCOL COPY MOVE;
          dav_ext_methods PROPFIND OPTIONS;
          create_full_put_path on;

          client_max_body_size 500m;
          client_body_temp_path /tmp/;
          autoindex on;
        '';
      };
    };

    systemd.services.nginx.serviceConfig.ReadWritePaths = ["/state/webdav"];

    networking.firewall.interfaces.${interfaceName}.allowedTCPPorts = [80 443];
  };
}
