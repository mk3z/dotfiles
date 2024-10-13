{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.tubearchivist;
  inherit (config.mkez.core) hostname;
  tailscaleInterface = config.services.tailscale.interfaceName;
  port = 8000;
in {
  options.mkez.services.tubearchivist.enable = mkEnableOption "Whether to enable TubeArchivist";
  config = mkIf cfg.enable {
    virtualisation.oci-containers.backend = "podman";

    virtualisation.oci-containers.containers = {
      tubearchivist-app = {
        image = "docker.io/bbilly1/tubearchivist";
        autoStart = true;
        ports = ["${toString port}:${toString port}"];
        volumes = [
          "/media/youtube:/youtube"
          "/var/cache/tubearchivist:/cache"
        ];
        environment = {
          UMASK = "002";
          ES_URL = "http://tubearchivist-es:9200";
          REDIS_HOST = "tubearchivist-redis";
          HOST_UID = "1000";
          HOST_GID = "1000";
          TA_HOST = "podman-tubearchivist-app.service localhost ${hostname}.intra.mkez.fi";
          TA_USERNAME = "tubearchivist";
          TA_PASSWORD = "hunter2";
          ELASTIC_PASSWORD = "hunter2";
          TZ = config.time.timeZone;
        };
      };

      tubearchivist-es = {
        image = "docker.io/bbilly1/tubearchivist-es";
        autoStart = true;
        environment = {
          ELASTIC_PASSWORD = "hunter2";
          UMASK = "002";
          ES_JAVA_OPTS = "-Xms1g -Xmx1g";
          "xpack.security.enabled" = "true";
          "discovery.type" = "single-node";
          "path.repo" = "/usr/share/elasticsearch/data/snapshot";
          TZ = config.time.timeZone;
        };
        volumes = ["/var/lib/tubearchivist/es:/usr/share/elasticsearch/data"];
        ports = ["9200:9200"];
      };

      tubearchivist-redis = {
        image = "docker.io/redis/redis-stack-server:latest";
        environment = {
          UMASK = "002";
          TZ = config.time.timeZone;
        };
        volumes = ["/state/tubearchivist/redis:/data"];
        ports = ["6379:6379"];
        dependsOn = ["tubearchivist-es"];
        autoStart = true;
      };
    };

    networking.firewall.interfaces.${tailscaleInterface}.allowedTCPPorts = [port];
  };
}
