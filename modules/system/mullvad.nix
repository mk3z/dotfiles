{
  lib,
  config,
  sysPersistDir,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.features.mullvad;
in {
  options.features.mullvad.enable = mkEnableOption "Enable Mullvad VPN";
  config = mkIf cfg.enable {
    services.mullvad-vpn.enable = true;

    environment.persistence."${sysPersistDir}".directories = [
      "/etc/mullvad-vpn"
    ];
  };
}
