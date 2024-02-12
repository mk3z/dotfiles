{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.ssh;
in {
  options.mkez.services.ssh.enable = mkEnableOption "Enable the OpenSSH server";
  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
    };
  };
}
