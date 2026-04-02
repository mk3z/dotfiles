{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        resize-by-cells = false;
        pad = "0x0 center";
      };
      csd.preferred = "none";
      cursor.beam-thickness = 1;
    };
  };
}
