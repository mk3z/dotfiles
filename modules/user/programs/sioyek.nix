{
  programs.sioyek = {
    enable = true;
    config = {
      page_separator_width = "4";

      # base16-sioyek (https://github.com/loiccoyle/base16-sioyek)
      # by Loic Coyle
      # Nord scheme byarcticicestudio

      custom_background_color = "#2e3440";
      custom_text_color = "#eceff4";

      page_separator_color = "#2e3440";
      search_highlight_color = "#ebcb8b";
      status_bar_color = "#2e3440";
      status_bar_text_color = "#eceff4";
      ui_text_color = "#eceff4";
      ui_selected_text_color = "#eceff4";
      ui_background_color = "#3b4252";
      ui_selected_background_color = "#4c566a";
      background_color = "#2e3440";
      visual_mark_color = "0.29803923 0.3372549 0.41568628 0.2";
      text_highlight_color = "#4c566a";
      link_highlight_color = "#81a1c1";
      synctex_highlight_color = "#bf616a";
    };
    bindings = {
      "move_right" = "m";
      "move_down" = "n";
      "move_up" = "e";
      "move_left" = "i";
      "next_item" = "k";
      "previous_item" = "K";

      "toggle_presentation_mode" = "P";

      "toggle_custom_color" = "u";
    };
  };

  xdg.mimeApps.defaultApplications."application/pdf" = "sioyek.desktop";
}
