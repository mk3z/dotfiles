{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.tailscale;
in {
  options.mkez.services.tailscale.enable = mkEnableOption "Whether to enable the tailscale client";
  config = mkIf cfg.enable {
    services.tailscale.enable = true;
    networking.firewall = {
      checkReversePath = "loose";
      trustedInterfaces = [config.services.tailscale.interfaceName];
    };

    # Stop mullvad from routing tailscale traffic
    # https://mullvad.net/en/help/split-tunneling-with-linux-advanced#excluding
    networking.nftables.ruleset = mkIf config.services.mullvad-vpn.enable ''
      table inet excludeTraffic {
        chain excludeOutgoing {
          type route hook output priority 0; policy accept;
          ip daddr 100.64.0.0/10 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
        }
      }
    '';
  };
}
