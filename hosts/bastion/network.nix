{
  config,
  lib,
  ...
}: let
  inherit (config.mkez.core) lanInterface;
in {
  networking = {
    hostName = config.mkez.core.hostname;
    hostId = "c34261c9";
    useDHCP = lib.mkDefault true;
  };

  networking.firewall.interfaces.${lanInterface}.allowedTCPPorts = [22];

  systemd.network = {
    enable = true;
    networks."10-wan" = {
      matchConfig.Name = lanInterface;
      networkConfig.DHCP = "ipv4";
      address = ["2a01:4f9:c011:a051::1/64"];
      routes = [{Gateway = "fe80::1";}];
    };
  };
}
