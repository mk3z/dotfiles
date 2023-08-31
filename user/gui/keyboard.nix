{ config, lib, pkgs, ... }:

{
  home = {
    packages = with pkgs; [ colemak-dh ];

    # Custom keyboard layout based on Colemak-DH ISO
    # replaces the backslash key with backspace
    # and number sign with backslash and pipe
    file.".xkb/symbols/colemat" = {
      recursive = true;
      text = ''
        xkb_symbols {
          include "us(colemak_dh_iso)"
          replace key <AB05> { [ BackSpace ] };
          replace key <AC12> { [ backslash, bar ] };
        };
      '';
    };
  };
}
