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
    services.tailscale = {
      enable = true;
      openFirewall = config.mkez.core.server;
    };
    networking.firewall.checkReversePath = "loose";

    # Stop mullvad from routing tailscale traffic
    # Sources for chains:
    # excludeOutgoing: https://mullvad.net/en/help/split-tunneling-with-linux-advanced#excluding
    # excludeIncoming: https://github.com/mullvad/mullvadvpn-app/issues/2097#issuecomment-799485645
    networking.nftables.tables.excludeTailscale = mkIf config.services.mullvad-vpn.enable {
      family = "inet";
      content = ''
        chain excludeOutgoing {
          type route hook output priority -100; policy accept
          ip daddr 100.64.0.0/10 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
        }
        chain excludeIncoming {
          type filter hook input priority -100; policy accept;
          ip daddr 100.64.0.0/10 ct mark set 0x00000f41 accept
        }
      '';
    };

    systemd.services.tailscaled.after = ["NetworkManager-wait-online.service"];
  };
}
