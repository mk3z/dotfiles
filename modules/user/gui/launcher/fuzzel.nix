{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption mkIf types;
  cfg = config.mkez.gui.launcher.fuzzel;
  inherit (config.programs) fuzzel;
in {
  options.mkez.gui.launcher.fuzzel = {
    enable = mkOption {
      type = types.bool;
      default = config.mkez.gui.launcher.primary == "fuzzel";
      description = "Whether to enable fuzzel";
    };
  };

  config = mkIf cfg.enable {
    programs.fuzzel.enable = true;
    mkez.gui.launcher.command = "${fuzzel.package}/bin/fuzzel";
  };
}
