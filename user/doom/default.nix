{ inputs, pkgs, homePersistDir, homeDirectory, ... }:

{
  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom;
    # Emacs 29 pure GTK build for Wayland support
    emacsPackage = pkgs.emacs-pgtk;
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

      magit-delta = super.magit-delta.overrideAttrs
        (esuper: { buildInputs = esuper.buildInputs ++ [ pkgs.git ]; });

      ob-mermaid = super.ob-mermaid.overrideAttrs (esuper: {
        buildInputs = esuper.buildInputs ++ [ pkgs.nodePackages.mermaid-cli ];
      });

      copilot = self.trivialBuild {
        src = inputs.copilot;
        pname = "copilot";
        ename = "copilot";
        buildInputs = with pkgs; [ nodejs ];
        packageRequires = with self; [ s dash editorconfig ];
      };
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

      # Github Copilot
      nodejs

      # Nix
      rnix-lsp
      nixfmt
    ];

    # Needed for copilot to work
    sessionVariables = { EMACS_PATH_COPILOT = "${inputs.copilot}"; };
  };

  # Disable automatic styling
  stylix.targets.emacs.enable = false;

}