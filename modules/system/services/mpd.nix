{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.mpd;
  streamPort = 8000;
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

    networking.firewall.allowedTCPPorts = [config.services.mpd.network.port streamPort];
  };
}
