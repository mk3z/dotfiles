{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.programs.octave;
in {
  options.mkez.programs.octave.enable = mkEnableOption "GNU Octave";
  config = mkIf cfg.enable {
    home.packages = [(pkgs.octaveFull.withPackages (opkgs: with opkgs; [communications signal statistics symbolic]))];
  };
}
