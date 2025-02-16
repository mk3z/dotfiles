{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.hardware.fprint;
in {
  options.mkez.hardware.fprint.enable = mkEnableOption "Whether to enable fingerprint reader";

  config = mkIf cfg.enable {
    systemd.services.fprintd = {
      wantedBy = ["multi-user.target"];
      serviceConfig.Type = "simple";
    };
    services.fprintd.enable = true;
  };
}
