{
  programs.zathura = {
    enable = true;
    mappings = {
      "m" = "scroll left";
      "n" = "scroll down";
      "e" = "scroll up";
      "i" = "scroll right";
      "u" = "recolor";
      "k" = "search forward";
      "K" = "search backward";
    };
    options = {
      "selection-clipboard" = "clipboard";
    };
  };
}
