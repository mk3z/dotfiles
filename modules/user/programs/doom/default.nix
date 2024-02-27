{
  lib,
  config,
  osConfig,
  inputs,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.editors.doom;
  inherit (osConfig.mkez.core) homePersistDir;
  inherit (osConfig.mkez.user) homeDirectory;
in {
  options.mkez.editors.doom.enable = mkEnableOption "Enable Doom Emacs";
  config = mkIf cfg.enable {
    programs.doom-emacs = {
      enable = true;
      doomPrivateDir = ./doom;
      emacsPackage = pkgs.emacs.override {withNativeCompilation = true;};
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
          version = "1.0";
          pname = "ammonite-term-repl";
          ename = "ammonite-term-repl";
          packageRequires = with self; [s scala-mode];
        };

        copilot = self.trivialBuild {
          src = inputs.copilot;
          version = "1.0";
          pname = "copilot";
          ename = "copilot";
          buildInputs = with pkgs; [nodejs];
          packageRequires = with self; [s dash editorconfig];
        };

        magit-delta =
          super.magit-delta.overrideAttrs
          (esuper: {buildInputs = esuper.buildInputs ++ [pkgs.git];});

        ob-ammonite = self.trivialBuild {
          src = inputs.ob-ammonite;
          version = "1.0";
          pname = "ob-ammonite";
          ename = "ob-ammonite";
          packageRequires = with self; [s ammonite-term-repl xterm-color];
        };

        ob-mermaid = super.ob-mermaid.overrideAttrs (esuper: {
          buildInputs = esuper.buildInputs ++ [pkgs.nodePackages.mermaid-cli];
        });
      };
    };

    # Enable Emacs daemon
    services.emacs.enable = true;

    home = {
      persistence."${homePersistDir}${homeDirectory}".directories = [
        ".cargo"
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
        (aspellWithDicts (dicts: with dicts; [en en-computers en-science fi]))
        python3

        # Github Copilot
        nodejs

        # LaTeX and Org-mode
        texlive.combined.scheme-full
        ## minted
        python311Packages.pygments

        # Bash
        nodePackages_latest.bash-language-server

        # C/C++
        clang-tools

        # Nix
        rnix-lsp
        nixfmt

        # Python
        python311Packages.python-lsp-server

        # Rust
        rust-analyzer
        (fenix.complete.withComponents [
          "cargo"
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
        scalafmt
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
  };
}
