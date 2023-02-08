{ pkgs, copilot }:

{
  home-manager.enable = true;

  ssh = {
    enable = true;
  };

  doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d;
    emacsPackage = pkgs.emacsPgtk;
    # Only init/packages so we only rebuild when those change.
    doomPackageDir = pkgs.linkFarm "doom-packages-dir" [
      {
        name = "init.el";
        path = ./doom.d/init.el;
      }
      {
        name = "packages.el";
        path = ./doom.d/packages.el;
      }
      {
        name = "config.el";
        path = pkgs.emptyFile;
      }
    ];
    emacsPackagesOverlay = self: super: {

      magit-delta = super.magit-delta.overrideAttrs (esuper: {
        buildInputs = esuper.buildInputs ++ [ pkgs.git ];
      });

      ob-mermaid = super.ob-mermaid.overrideAttrs (esuper: {
        buildInputs = esuper.buildInputs ++ [ pkgs.nodePackages.mermaid-cli ];
      });

      copilot = self.trivialBuild {
        pname  = "copilot";
        src = copilot;
      };
    };
  };

  bat.enable = true;

  git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "Matias Zwinger";
    userEmail = "matias.zwinger@protonmail.com";
  };

  fish = import ./fish.nix;

  foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        font = "monospace:size=10";
      };
      scrollback = {
        lines = 10000;
      };
      mouse = {
        hide-when-typing = "yes";
      };
      colors = {
        alpha = 0.85;
      };
    };
  };

  fzf.enable = true;

  jq.enable = true;

  lsd = {
    enable = true;
    enableAliases = true;
  };

  mako.enable = true;

  starship = import ./starship.nix;

  waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        position = "top";
        height = 16;
        modules-left = [ "sway/workspaces" "sway/mode" "sway/window" ];
      };
    };
    style = ''
      * {
        font-family: "Monospace";
      }'';
  };
}
