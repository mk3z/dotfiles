{pkgs, ...}: {
  programs.helix = {
    languages = {
      language = [
        {
          name = "c";
          auto-format = true;
          indent = {
            tab-width = 2;
            unit = "  ";
          };
        }
        {
          name = "cpp";
          auto-format = true;
        }
        {
          name = "elixir";
          auto-format = true;
        }
        {
          name = "haskell";
          auto-format = true;
        }
        {
          name = "text";
          file-types = ["txt"];
          language-servers = ["ltex-ls"];
          scope = "text.raw";
          roots = [];
        }
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
            args = [
              "-q"
              "--name=foo.ml" # ocamlformat requires a filename when formatting from stdin
              "-"
            ];
          };
        }
        {
          name = "python";
          language-servers = ["ruff"];
          auto-format = true;
        }
        {
          name = "scala";
          auto-format = true;
        }
        {
          name = "typescript";
          auto-format = true;
        }
        {
          name = "typst";
          language-servers = ["typst-lsp" "typos-lsp"];
          auto-format = true;
          formatter.command = "${pkgs.typstyle}/bin/typstyle";
        }
      ];
      language-server = {
        elixir-ls = {
          command = "elixir-ls";
          environment = {"SHELL" = "${pkgs.bash}/bin/bash";};
          config.elixirLS.dialyzerEnabled = false;
        };
        haskell-language-server = {
          config.haskell.formattingProvider = "ormolu";
        };
        ltex-ls = {
          command = "${pkgs.ltex-ls}/bin/ltex-ls";
        };
        ruff = {
          command = "${pkgs.ruff}/bin/ruff";
          args = ["server" "--preview"];
        };
        typos-lsp = {
          command = "${pkgs.typos-lsp}/bin/typos-lsp";
        };
      };
    };

    extraPackages = with pkgs; [
      # Ansible
      ansible-language-server

      # Bash
      nodePackages_latest.bash-language-server

      # C/C++
      clang-tools
      lldb

      # Dockerfile
      dockerfile-language-server-nodejs

      # Elixir
      elixir-ls
      rtx

      # HTML, CSS, JSON
      vscode-langservers-extracted

      # JavaScript
      nodePackages.typescript-language-server

      # LaTeX
      texlab

      # Markdown
      marksman

      # Nix
      nil

      # OCaml
      ocamlPackages.ocaml-lsp

      # Rust
      rust-analyzer
      (fenix.complete.withComponents [
        "cargo"
        "clippy"
        "rust-src"
        "rustc"
        "rustfmt"
      ])

      # Svelte
      nodePackages.svelte-language-server

      # Typst
      typst-lsp

      # YAML
      yaml-language-server
    ];
  };
}
