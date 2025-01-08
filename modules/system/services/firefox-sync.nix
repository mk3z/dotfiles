{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkOption mkEnableOption mkIf;
  cfg = config.mkez.services.firefox-sync;
  inherit (config.mkez.core) hostname;
  inherit (config.services.tailscale) interfaceName;
in {
  options.mkez.services.firefox-sync = {
    enable = mkEnableOption "Enable the Firefox Sync server";
    port = mkOption {
      description = "Internal port. External port will always be 5000.";
      type = lib.types.int;
      default = 5000;
    };
  };

  config = mkIf cfg.enable {
    age.secrets.firefox-sync-secrets.file = ../../../secrets/firefox-sync-secrets.age;

    services = {
      firefox-syncserver = {
        enable = true;
        secrets = config.age.secrets.firefox-sync-secrets.path;
        singleNode = {
          enable = true;
          hostname = "intra.mkez.fi";
          url = "https://intra.mkez.fi/ff-sync/";
        };
        settings.port = cfg.port;
        logLevel = "trace";
      };

      mysql.package = pkgs.mariadb;

      nginx = {
        enable = true;
        virtualHosts."${hostname}.intra.mkez.fi".locations."/ff-sync".proxyPass = "http://localhost:${toString cfg.port}";
      };
    };

    networking.firewall.interfaces.${interfaceName}.allowedTCPPorts = [80 443];
  };
}
