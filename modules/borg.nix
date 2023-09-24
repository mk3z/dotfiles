{ config, username, ... }:
{
  age.secrets.borg.file = ../secrets/borg.age;

  services.borgbackup.jobs = {
    home = {
      repo = "ssh://zh3598@zh3598.rsync.net/~/backups/${config.networking.hostName}/home";
      encryption = {
        mode = "repokey-blake2";
        passCommand = "cat ${config.age.secrets.borg.path}";
      };
      environment.BORG_RSH = "ssh -i /etc/ssh/ssh_host_ed25519_key";
      extraCreateArgs = "--verbose --stats --checkpoint-interval 600";
      paths = "/persist/home/${username}";
      exclude = [
        ".cache"
        "*/.cache"
        "*/cache"
        "*/Cache"
        "*/Code Cache"
      ];
      compression = "auto,zstd";
    };
  };
}
