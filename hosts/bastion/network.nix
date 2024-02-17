{
  config,
  lib,
  ...
}: {
  networking = {
    hostName = config.mkez.core.hostname;
    hostId = "c34261c9";
    useDHCP = lib.mkDefault true;
  };

  systemd.network = {
    enable = true;
    networks."10-wan" = {
      matchConfig.Name = "enp1s0";
      networkConfig.DHCP = "ipv4";
      address = ["2a01:4f9:c011:a051::1/64"];
      routes = [
        {routeConfig.Gateway = "fe80::1";}
      ];
    };
  };
}
