{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.mullvad;
  inherit (config.mkez.core) sysPersistDir;
in {
  options.mkez.services.mullvad.enable = mkEnableOption "Enable Mullvad VPN";
  config = mkIf cfg.enable {
    services.mullvad-vpn.enable = true;

    environment.persistence."${sysPersistDir}".directories = [
      "/etc/mullvad-vpn"
    ];
  };
}
