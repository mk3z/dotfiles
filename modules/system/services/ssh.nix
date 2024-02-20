{
  lib,
  config,
  username,
  sysPersistDir,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.ssh;
in {
  options.mkez.services.ssh.enable = mkEnableOption "Enable the OpenSSH server";
  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };

    users.users.${username}.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKVXV+51+7Evucq9Qi9QCs2LugQii6AjvDfIg3u7oiOe"
    ];

    environment.etc = {
      "ssh/ssh_host_ed25519_key".source = "${sysPersistDir}/etc/ssh/ssh_host_ed25519_key";
      "ssh/ssh_host_ed25519_key.pub".source = "${sysPersistDir}/etc/ssh/ssh_host_ed25519_key.pub";
    };
  };
}
