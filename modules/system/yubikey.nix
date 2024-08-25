{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.features.yubikey;
in {
  options.mkez.features.yubikey.enable = mkEnableOption "Whether to enable Yubikey support";
  config = mkIf cfg.enable {
    services.udev.packages = [pkgs.yubikey-personalization];
    environment.systemPackages = with pkgs; [yubikey-manager];
  };
}
