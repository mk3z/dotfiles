{pkgs, ...}: {
  programs.helix = {
    enable = true;

    settings = {
      theme = "nord";

      editor = {
        scrolloff = 8;
        line-number = "relative";
        cursorline = true;
        auto-save = true;
        bufferline = "multiple";
        color-modes = true;

        statusline = {
          mode = {
            normal = "N";
            insert = "I";
            select = "S";
          };
          left = [
            "mode"
            "spinner"
            "spacer"
            "version-control"
            "file-name"
            "read-only-indicator"
            "file-modification-indicator"
            "position"
            "position-percentage"
            "primary-selection-length"
          ];
          right = [
            "diagnostics"
            "selections"
            "register"
            "file-encoding"
            "file-line-ending"
          ];
        };

        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "block";
        };

        indent-guides.render = true;

        soft-wrap.enable = true;
      };

      keys = let
        common = {
          u = "insert_mode";
          U = "insert_at_line_start";

          f = "move_next_word_end";
          F = "move_next_long_word_end";

          j = "find_next_char";
          J = "find_prev_char";

          k = "search_next";
          K = "search_prev";
        };
      in {
        normal =
          common
          // {
            m = "move_char_left";
            n = "move_line_down";
            e = "move_line_up";
            i = "move_char_right";

            N = "join_selections";
            A-J = "join_selections_space";
            E = "keep_selections";
            A-K = "remove_selections";

            l = "undo";
            L = "redo";

            G = "goto_last_line";
            esc = "collapse_selection";

            # Emacs
            A-x = "command_palette";

            z = {
              n = "scroll_down";
              e = "scroll_up";
            };

            h = {
              m = "match_brackets";
              s = "surround_add";
              r = "surround_replace";
              d = "surround_delete";
              a = "select_textobject_around";
              i = "select_textobject_inner";
            };

            C-w = {
              m = "jump_view_left";
              n = "jump_view_down";
              e = "jump_view_up";
              i = "jump_view_right";
              M = "swap_view_left";
              N = "swap_view_down";
              E = "swap_view_up";
              I = "swap_view_right";
            };
          };

        insert = {
          up = "no_op";
          down = "no_op";
          left = "no_op";
          right = "no_op";
          pageup = "no_op";
          pagedown = "no_op";
          home = "no_op";
          end = "no_op";
        };

        select =
          common
          // {
            m = "extend_char_left";
            n = "extend_line_down";
            e = "extend_line_up";
            i = "extend_char_right";
          };
      };
    };

    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "${pkgs.alejandra}/bin/alejandra";
            args = ["-q"];
          };
        }
        {
          name = "ocaml";
          auto-format = true;
          formatter = {
            command = "${pkgs.ocamlformat}/bin/ocamlformat";
            args = ["-i" "--enable-outside-detected-project"];
          };
        }
        {
          name = "scala";
          auto-format = true;
        }
      ];
    };

    extraPackages = with pkgs; [
      # Bash
      nodePackages_latest.bash-language-server

      # C/C++
      clang-tools

      # LaTeX
      texlab

      # Nix
      nil

      # OCaml
      ocamlPackages.ocaml-lsp
    ];
  };

  stylix.targets.helix.enable = false;
}
