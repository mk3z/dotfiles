{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
in {
  networking = mkIf (config.mkez.core.hostname
    != "nixos-iso") {
    firewall.enable = true;
    networkmanager = {
      enable = true;
      wifi.macAddress = "random";
      ethernet.macAddress = "random";
    };
  };
}
