{
  lib,
  config,
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
      settings.PasswordAuthentication = false;
    };

    environment.etc = {
      "ssh/ssh_host_ed25519_key".source = "${sysPersistDir}/etc/ssh/ssh_host_ed25519_key";
      "ssh/ssh_host_ed25519_key.pub".source = "${sysPersistDir}/etc/ssh/ssh_host_ed25519_key.pub";
    };
  };
}
