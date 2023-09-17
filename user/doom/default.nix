{ inputs, pkgs, homePersistDir, homeDirectory, ... }:

{
  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom;
    emacsPackage = pkgs.emacs29.override { withNativeCompilation = true; };
    # Only rebuild if init or packages change
    doomPackageDir = pkgs.linkFarm "doom-packages-dir" [
      {
        name = "init.el";
        path = ./doom/init.el;
      }
      {
        name = "packages.el";
        path = ./doom/packages.el;
      }
      {
        name = "config.el";
        path = pkgs.emptyFile;
      }
    ];
    emacsPackagesOverlay = self: super: {

      ammonite-term-repl = self.trivialBuild {
        src = inputs.ammonite-term-repl;
        pname = "ammonite-term-repl";
        ename = "ammonite-term-repl";
        packageRequires = with self; [ s scala-mode ];
      };

      copilot = self.trivialBuild {
        src = inputs.copilot;
        pname = "copilot";
        ename = "copilot";
        buildInputs = with pkgs; [ nodejs ];
        packageRequires = with self; [ s dash editorconfig ];
      };

      magit-delta = super.magit-delta.overrideAttrs
        (esuper: { buildInputs = esuper.buildInputs ++ [ pkgs.git ]; });

      ob-ammonite = self.trivialBuild {
        src = inputs.ob-ammonite;
        pname = "ob-ammonite";
        ename = "ob-ammonite";
        packageRequires = with self; [ s ammonite-term-repl xterm-color ];
      };

      ob-mermaid = super.ob-mermaid.overrideAttrs (esuper: {
        buildInputs = esuper.buildInputs ++ [ pkgs.nodePackages.mermaid-cli ];
      });

    };
  };

  # Enable Emacs daemon
  services.emacs.enable = true;

  home = {

    persistence."${homePersistDir}${homeDirectory}".directories = [
      # Github copilot credentials
      ".config/github-copilot"
      # Emacs cache among other things
      ".local/share/doom"
    ];

    packages = with pkgs; [
      # Ivy
      fzf
      ripgrep

      # Spell checking
      aspell
      python3
      aspellDicts.en
      aspellDicts.en-science
      aspellDicts.en-computers
      aspellDicts.fi

      # Github Copilot
      nodejs

      # LaTeX and Org-mode
      texlive.combined.scheme-full
      ## minted
      python311Packages.pygments

      # Nix
      rnix-lsp
      nixfmt

      # Python
      python311Packages.python-lsp-server

      # Rust
      rust-analyzer
      (fenix.complete.withComponents [
        "clippy"
        "rust-src"
        "rustc"
        "rustfmt"
      ])

      # Scala
      bloop
      metals
      (pkgs.writeShellScriptBin "metals-emacs" "metals")
      sbt
    ];

    sessionVariables = {
      # Needed for copilot to work
      EMACS_PATH_COPILOT = "${inputs.copilot}";
      # Make lsp-mode faster
      LSP_USE_PLISTS = "true";
    };
  };

  # Disable automatic styling
  stylix.targets.emacs.enable = false;

}
