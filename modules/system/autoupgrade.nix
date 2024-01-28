{
  lib,
  config,
  homeDirectory,
  ...
}: let
  inherit (lib) mkEnableOption;
  cfg = config.features.autoupgrade;
in {
  options.features.autoupgrade.enable = mkEnableOption "Enable nixpkgs auto updating";
  config = {
    system.autoUpgrade = {
      inherit (cfg) enable;
      flake = "${homeDirectory}/Projects/dotfiles";
      flags = [
        "--update-input"
        "nixpkgs"
        "--update-input"
        "nur"
        "--commit-lock-file"
        "-L"
      ];
      persistent = true;
      dates = "daily";
    };
  };
}
