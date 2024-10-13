{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.vaultwarden;
  port = 8222;
  tailscaleIntreface = config.services.tailscale.interfaceName;
  inherit (config.mkez.core) hostname;
in {
  options.mkez.services.vaultwarden.enable = mkEnableOption "Enable Vaultwarden";
  config = mkIf cfg.enable {
    age.secrets.vaultwarden_env = {
      file = ../../../secrets/vaultwarden.env.age;
    };

    services = {
      vaultwarden = {
        enable = true;
        environmentFile = config.age.secrets.vaultwarden_env.path;
        config = {
          DOMAIN = "https://nas.intra.mkez.fi/vaultwarden";
          ROCKET_ADDRESS = "127.0.0.1";
          ROCKET_PORT = port;
          SIGNUPS_ALLOWED = false;
        };
        backupDir = "/backup/vaultwarden";
      };

      nginx = {
        enable = true;
        virtualHosts."${hostname}.intra.mkez.fi" = {
          locations."/vaultwarden".proxyPass = "http://localhost:${toString port}";
        };
      };
    };
    networking.firewall.interfaces.${tailscaleIntreface}.allowedTCPPorts = [80 443];
  };
}
