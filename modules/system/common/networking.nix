{
  lib,
  config,
  ...
}: let
  inherit (config.mkez.user) username;
in {
  networking = {
    firewall.enable = true;
    # Use nftables instead of iptables
    nftables.enable = true;
    networkmanager = {
      enable = true;
      wifi.macAddress = "random";
      ethernet.macAddress = lib.mkIf (!config.mkez.core.server) "random";
    };
  };

  users.users.${username}.extraGroups = ["networkmanager"];
}
