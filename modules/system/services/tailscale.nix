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
      trustedInterfaces = ["tailscale0"];
      allowedUDPPorts = [config.services.tailscale.port];
    };
  };
}
