{config, ...}: let
  inherit (config.mkez.core) lanInterface;
in {
  services.nginx.virtualHosts."gameserver" = {
    listen = [
      {
        addr = "192.168.1.3";
        port = 1337;
      }
    ];
    locations."/" = {
      root = "/media/games";
      extraConfig = "autoindex on;";
    };
  };

  networking.firewall.interfaces.${lanInterface}.allowedTCPPorts = [1337];
}
