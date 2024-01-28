{
  programs.wofi = {
    enable = true;
    style = ''
      * {
        font-family: monospace;
      }

      #input {
        border-radius: 0;
      }
    '';
  };
}
