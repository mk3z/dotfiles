{pkgs, ...}: {
  home = {
    packages = with pkgs; [colemak-dh];

    # Custom keyboard layout based on Colemak-DH ISO
    file.".xkb/symbols/colemat" = {
      recursive = true;
      text = ''
        xkb_symbols {
          include "us(colemak_dh_iso)"

          key <AD03> { [ f, F, exclam ] };
          key <AD04> { [ p, P, at ] };

          key <AC01> { [ a, A, adiaeresis, Adiaeresis ] };
          key <AC02> { [ r, R, asciicircum ] };
          key <AC03> { [ s, S, parenleft ] };
          key <AC04> { [ t, T, parenright ] };
          key <AC05> { [ g, G, bracketleft ] };
          key <AC06> { [ m, M, bracketright ] };
          key <AC07> { [ n, N, braceleft ] };
          key <AC07> { [ n, N, braceleft ] };
          key <AC08> { [ e, E, braceright ] };
          key <AC09> { [ i, I, dollar ] };
          key <AC10> { [ o, O, odiaeresis, Odiaeresis ] };
          key <AC11> { [ apostrophe, quotedbl, numbersign ] };
          key <AC12> { [ backslash, bar ] };

          key <LSGT> { [ z, Z, percent ] };
          key <AB01> { [ x, X, ampersand ] };
          key <AB02> { [ c, C, asterisk ] };
          key <AB03> { [ d, D, less ] };
          key <AB04> { [ v, V, minus, underscore ] };
          key <AB05> { [ BackSpace, Delete ] };
          key <AB06> { [ k, K, plus, equal ] };
          key <AB07> { [ h, H, greater ] };
        };
      '';
    };
  };
}
