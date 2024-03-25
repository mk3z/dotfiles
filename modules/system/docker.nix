{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.docker;
  inherit (config.mkez.user) username;
in {
  options.mkez.services.docker.enable = mkEnableOption "Enable Docker";
  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;
    environment.systemPackages = with pkgs; [docker-compose];
    users.users.${username}.extraGroups = ["docker"];
  };
}
