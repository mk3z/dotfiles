{ pkgs, lib, inputs }:

{
  home-manager.enable = true;

  ssh.enable = true;

  doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom;
    emacsPackage = pkgs.emacs28.override {
      withPgtk = true;
      withNativeCompilation = true;
    };
    # Only init/packages so we only rebuild when those change.
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

  bat.enable = true;

  git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "Matias Zwinger";
    userEmail = "matias.zwinger@protonmail.com";
    extraConfig.commit.verbose = true;
    delta.enable = true;
  };

  firefox = import ./firefox.nix { inherit pkgs; };

  fish = import ./fish.nix { inherit inputs; };

  fzf.enable = true;

  jq.enable = true;

  kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    settings.window_padding_width = 2;
  };

  lsd = {
    enable = true;
    enableAliases = true;
  };

  mpv.enable = true;

  nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  starship = import ./starship.nix;

  swaylock = {
    enable = true;
    settings.font = "monospace";
  };

  vim = {
    enable = true;
    extraConfig = ''
      noremap e k
      noremap i l
      noremap k n
      noremap l u
      noremap m h
      noremap n j
      noremap u i
      noremap E K
      noremap I L
      noremap K N
      noremap L U
      noremap M H
      noremap N J
      noremap U I
  '';
  };

  vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      arcticicestudio.nord-visual-studio-code
      bbenoist.nix
      github.copilot
      kamadorueda.alejandra
      vscodevim.vim
    ];
    userSettings = {
      "editor.inlineSuggest.enabled" = true;
      "security.workspace.trust.untrustedFiles" = "open";
      "window.menuBarVisibility" = "hidden";
      "workbench.startupEditor" = "none";
      "workbench.colorTheme" = "Nord";
    };
  };

  waybar = import ./waybar.nix;

  wofi = {
    enable = true;
    style = ''
      * {
        font-family: monospace;
      }

      #input {
        border-radius: 0;
      }
    '';
  };
}
