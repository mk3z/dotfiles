{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.mkez.services.borg;
  inherit (config.mkez.user) username;
in {
  options.mkez.services.borg.enable = mkEnableOption "Enable Borg backup";
  config = mkIf cfg.enable {
    age.secrets.borg.file = ../../../secrets/borg.age;

    services.borgbackup.jobs = {
      home = {
        repo = "ssh://zh3598@zh3598.rsync.net/~/backups/${config.networking.hostName}/home";
        encryption = {
          mode = "repokey-blake2";
          passCommand = "cat ${config.age.secrets.borg.path}";
        };
        environment.BORG_RSH = "ssh -o 'StrictHostKeyChecking=no' -i /etc/ssh/ssh_host_ed25519_key";
        extraCreateArgs = "--verbose --stats --checkpoint-interval 600";
        paths = "/persist/home/${username}";
        exclude = [
          ".cache"
          "*/.cache"
          "*/cache"
          "*/Cache"
          "*/Code Cache"
          "Downloads/persistent"
        ];
        compression = "auto,zstd";
      };
    };
  };
}
