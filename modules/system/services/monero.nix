{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.monero;
  inherit (config.mkez.core) homePersistDir;
  inherit (config.mkez.user) username;
in {
  options.mkez.services.monero = {
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
