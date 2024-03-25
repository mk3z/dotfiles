{
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

  networking.firewall.interfaces."enp37s0".allowedTCPPorts = [1337];
}
