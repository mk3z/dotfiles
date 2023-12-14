{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      vim-numbertoggle
    ];

    plugins = {
      barbecue.enable = true;

      clangd-extensions.enable = true;

      comment-nvim.enable = true;

      coq-nvim = {
        enable = true;
        autoStart = "shut-up";
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

      leap.enable = true;

      lsp = {
        enable = true;

        keymaps.lspBuf = {
          h = "hover";
          gD = "references";
          gd = "definition";
          gi = "implementation";
          gy = "type_definition";
        };

        servers = {
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

      lean = {
        enable = true;
        mappings = true;
        lsp.enable = true;
      };

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

      nvim-autopairs.enable = true;

      nvim-colorizer.enable = true;

      neogit.enable = true;

      rust-tools.enable = true;

      surround.enable = true;

      telescope = {
        enable = true;
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
          # Emac moment
          "<M-x>" = {
            action = "commands";
            desc = "Commands";
          };
        };
      };

      treesitter.enable = true;

      which-key.enable = true;
    };
  };
}
