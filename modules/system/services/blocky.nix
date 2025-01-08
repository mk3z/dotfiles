{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.services.tailscale) interfaceName;
  cfg = config.mkez.services.blocky;
in {
  options.mkez.services.blocky.enable = mkEnableOption "Enable Blocky DNS proxy";
  config = mkIf cfg.enable {
    services.blocky = {
      enable = true;
      settings = {
        ports.dns = "100.99.0.2:53";
        upstreams.groups.default = [
          "https://dns.quad9.net/dns-query"
          "https://one.one.one.one/dns-query"
        ];
        bootstrapDns = {
          upstream = "https://one.one.one.one/dns-query";
          ips = ["1.1.1.1" "1.0.0.1"];
        };
        blocking = {
          denylists = {
            ads = ["https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"];
          };
          clientGroupsBlock = {
            default = ["ads"];
          };
        };
      };
    };

    networking.firewall.interfaces.${interfaceName}.allowedUDPPorts = [53];
  };
}
