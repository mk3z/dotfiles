{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.syncthing;
  guiPort = 8384;
  inherit (config.services.tailscale) interfaceName;
  inherit (config.mkez.core) server;
  inherit (config.mkez.user) username;
  inherit (config.users.users."${config.mkez.user.username}") group;
in {
  options.mkez.services.syncthing.enable = mkEnableOption "Enable Syncthing";
  config = mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      guiAddress = "0.0.0.0:${toString guiPort}";
      user =
        if server
        then "syncthing"
        else username;
      group =
        if server
        then "syncthing"
        else group;
    };

    networking.firewall = {
      allowedTCPPorts = [22000];
      allowedUDPPorts = [22000 21027];
    };

    networking.firewall.interfaces.${interfaceName}.allowedTCPPorts = mkIf config.mkez.core.server [guiPort];
  };
}
