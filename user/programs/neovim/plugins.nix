{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = [
      pkgs.vimPlugins.vim-numbertoggle
      {
        plugin = pkgs.vimPlugins.neoscroll-nvim;
        config = ''
          lua require 'neoscroll'.setup({ })
        '';
      }
    ];

    keymaps = [
      {
        action = "<cmd>Telescope projects projects<CR>";
        key = "<leader>p";
        mode = "n";
      }
      {
        action = "<cmd>Lspsaga hover_doc<CR>";
        key = "h";
        mode = "n";
      }
      {
        action = "<cmd>Lspsaga code_action<CR>";
        key = "<leader>ca";
        mode = "n";
      }
      {
        action = "<cmd>Lspsaga finder<CR>";
        key = "<leader>cf";
        mode = "n";
      }
      {
        action = "<cmd>Lspsaga peek_definition<CR>";
        key = "<leader>cd";
        mode = "n";
      }
      {
        action = "<cmd>Lspsaga peek_type_definition<CR>";
        key = "<leader>cd";
        mode = "n";
      }
      {
        action = "<cmd>Lspsaga incoming_calls<CR>";
        key = "<leader>ci";
        mode = "n";
      }
      {
        action = "<cmd>Lspsaga outgoing_calls<CR>";
        key = "<leader>co";
        mode = "n";
      }
    ];

    plugins = {
      clangd-extensions.enable = true;

      comment-nvim.enable = true;

      coq-nvim = {
        enable = true;
        autoStart = "shut-up";
        installArtifacts = true;
      };

      crates-nvim.enable = true;

      emmet.enable = true;

      fidget.enable = true;

      flash.enable = true;

      gitsigns.enable = true;

      hardtime.enable = true;

      hmts.enable = true;

      inc-rename.enable = true;

      indent-blankline.enable = true;

      intellitab.enable = true;

      lastplace.enable = true;

      lean = {
        enable = true;
        mappings = true;
        lsp.enable = true;
      };

      leap.enable = true;

      lint.enable = true;

      lsp = {
        enable = true;

        keymaps.lspBuf = {
          gD = "references";
          gd = "definition";
          gi = "implementation";
          gy = "type_definition";
        };

        servers = {
          hls.enable = true;
          nixd = {
            enable = true;
            settings = {
              formatting.command = "${pkgs.alejandra}/bin/alejandra -q";
              options.target.installable = "<flakeref>#nixosConfigurations.<name>.options";
            };
          };
        };
      };

      lsp-format.enable = true;

      lspsaga.enable = true;

      lualine = {
        enable = true;
        componentSeparators = {
          left = "";
          right = "";
        };
        sectionSeparators = {
          left = "";
          right = "";
        };
      };

      markdown-preview.enable = true;

      nvim-autopairs.enable = true;

      nvim-colorizer.enable = true;

      neogit.enable = true;

      project-nvim.enable = true;

      rust-tools.enable = true;

      surround.enable = true;

      telescope = {
        enable = true;
        extensions.project-nvim.enable = true;
        keymaps = {
          "<leader>f" = {
            action = "find_files";
            desc = "Find files";
          };
          "<leader>/" = {
            action = "live_grep";
            desc = "Search files";
          };
          "<leader><leader>" = {
            action = "buffers";
            desc = "Open buffers";
          };
          "<leader>r" = {
            action = "oldfiles";
            desc = "Recent files";
          };
          # Emacs moment
          "<M-x>" = {
            action = "commands";
            desc = "Commands";
          };
        };
      };

      treesitter.enable = true;

      trouble.enable = true;

      which-key.enable = true;
    };
  };
}
