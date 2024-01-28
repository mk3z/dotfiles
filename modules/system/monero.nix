{
  lib,
  config,
  pkgs,
  username,
  homePersistDir,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.features.monero;
in {
  options.features.monero = {
    enable = mkEnableOption "Enable Monero daemon";
    persist = mkEnableOption "Persist the ~/.xmr directory";
  };
  config = {
    services.monero = {
      inherit (cfg) enable;
      mining.enable = false;
    };

    environment = {
      systemPackages = [pkgs.monero-cli];
      persistence.${homePersistDir}.users.${username}.directories = mkIf cfg.persist [".xmr"];
    };
  };
}
