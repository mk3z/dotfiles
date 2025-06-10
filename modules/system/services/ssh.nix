{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.ssh;
  inherit (config.services.openssh) ports;
  inherit (config.mkez.core) sysPersistDir;
  inherit (config.mkez.user) username;
in {
  options.mkez.services.ssh.enable = mkEnableOption "Enable the OpenSSH server";
  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      openFirewall = false;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "without-password";
      };
    };

    networking.firewall.allowedTCPPorts = ports;

    # FIXME make this more DRY
    users.users = {
      root.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKVXV+51+7Evucq9Qi9QCs2LugQii6AjvDfIg3u7oiOe"
      ];
      ${username}.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKVXV+51+7Evucq9Qi9QCs2LugQii6AjvDfIg3u7oiOe"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPnipVM0FRYNEMxGrBGM0zl8FD8jNitjuyksfCFiZaGZ" # buildkey
      ];
    };

    environment.etc = {
      "ssh/ssh_host_ed25519_key".source = "${sysPersistDir}/etc/ssh/ssh_host_ed25519_key";
      "ssh/ssh_host_ed25519_key.pub".source = "${sysPersistDir}/etc/ssh/ssh_host_ed25519_key.pub";
    };
  };
}
