{lib, ...}: let
  inherit (lib) mkOption types;
in {
  options.mkez.gui.launcher = {
    primary = mkOption {
      type = types.enum ["fuzzel" "rofi"];
    };
    command = mkOption {
      type = types.str;
    };
  };

  imports = [
    ./fuzzel.nix
    ./rofi.nix
  ];
}
