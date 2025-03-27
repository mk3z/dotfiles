{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mkez.user) username;
  cfg = config.mkez.hardware.zsa;
in {
  options.mkez.hardware.zsa.enable = mkEnableOption "Whether to enable ZSA keyboard support";
  config = mkIf cfg.enable {
    hardware.keyboard.zsa.enable = true;
    users.users.${username}.extraGroups = ["plugdev"];
  };
}
