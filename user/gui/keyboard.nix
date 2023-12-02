{pkgs, ...}: {
  home = {
    packages = with pkgs; [colemak-dh];

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

          key <AC03> { [ s, S, parenleft ] };
          key <AC04> { [ t, T, parenright ] };

          key <AC05> { [ g, G, less ] };
          key <AC06> { [ m, M, greater ] };

          key <AC07> { [ n, N, braceleft ] };
          key <AC08> { [ e, E, braceright ] };

          key <AB03> { [ d, D, bracketleft] };
          key <AB07> { [ h, H, bracketright ] };
        };
      '';
    };
  };
}
