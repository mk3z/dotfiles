{
  programs.sioyek = {
    enable = true;
    bindings = {
      "move_right" = "m";
      "move_down" = "n";
      "move_up" = "e";
      "move_left" = "i";
      "next_item" = "k";
      "previous_item" = "K";

      "toggle_dark_mode" = "u";
    };
  };

  xdg.mimeApps.defaultApplications."application/pdf" = "sioyek.desktop";
}
