{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.mpd;
  streamPort = 8000;
  inherit (config.services.tailscale) interfaceName;
in {
  options.mkez.services.mpd.enable = mkEnableOption "Whether to enable the MPD server";
  config = mkIf cfg.enable {
    services.mpd = {
      enable = true;
      startWhenNeeded = true;
      network.listenAddress = "any";
      musicDirectory = "/media/music";
      extraConfig = ''
        audio_output {
          type "httpd"
          name "HTTP stream"
          port "${toString streamPort}"
          always_on "yes"
          tags "yes"
        }
      '';
    };

    networking.firewall.interfaces.${interfaceName}.allowedTCPPorts = [config.services.mpd.network.port streamPort];
  };
}
