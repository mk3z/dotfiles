{
  lib,
  config,
  pkgs,
  username,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.features.docker;
in {
  options.mkez.features.docker.enable = mkEnableOption "Enable Docker";
  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;
    environment.systemPackages = with pkgs; [docker-compose];
    users.users.${username}.extraGroups = ["docker"];
  };
}
