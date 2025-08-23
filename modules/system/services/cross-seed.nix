{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkOption mkIf;
  inherit (lib.lists) range;
  inherit (lib.strings) concatStrings;

  cfg = config.mkez.services.cross-seed;

  apikey = "060ac325785942f1800e9c49c039426a"; # API is only exposed locally
  port = 2468;

  inherit (config.services.transmission.settings) rpc-port;
  transmissionHome = config.services.transmission.home;
  watchDir = config.services.transmission.settings.watch-dir;

  configFile =
    pkgs.writeText "config.js"
    ''
      module.exports = {
        torznab: [
      ${
        concatStrings (
          map
          (num: "\"http://10.88.0.1:9696/prowlarr/" + toString num + "/api?apikey=${apikey}&extended=1&t=search\",\n")
          (range 1 30)
        )
      }
        ],
        torrentDir: "/torrents",
        outputDir: "/cross-seed",

        torrentClients: ["transmission:http://10.88.0.1:${toString rpc-port}/transmission/rpc"],
        action: "inject",

        delay: 30,
        rssCadence: "10 minutes",
        searchCadence: "1 day",
        excludeOlder: "2 weeks",
        excludeRecentSearch: "3 days",
      }
    '';
in {
  options.mkez.services.cross-seed = {
    enable = mkEnableOption "Whether to enable cross-seed";
    dataDir = mkOption {
      default = "/state/cross-seed";
      type = lib.types.str;
    };
  };

  config = mkIf cfg.enable {
    virtualisation.oci-containers.backend = "podman";

    system.activationScripts.symlinkCrossSeedConfig = ''
      mkdir -p ${cfg.dataDir}
      cp -f ${configFile} ${cfg.dataDir}/config.js
    '';

    virtualisation.oci-containers.containers = {
      cross-seed = {
        image = "ghcr.io/cross-seed/cross-seed";
        autoStart = true;
        ports = ["${toString port}:${toString port}"];
        volumes = [
          "${cfg.dataDir}:/config"
          "${watchDir}:/cross-seed"
          "${transmissionHome}/.config/transmission-daemon/torrents:/torrents:ro"
        ];
        cmd = ["daemon"];
      };
    };
  };
}
