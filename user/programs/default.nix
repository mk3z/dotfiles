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

  alacritty = {
    enable = true;
    settings = {
      window.padding = {
        x = 2;
        y = 0;
      };
      dynamic_padding = true;
      decorations = "none";
      opacity = 0.85;
      startup_mode = "Maximized";
      font.size = 12;
      cursor.style.shape = "Beam";
    };
  };

  bat.enable = true;

  git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "Matias Zwinger";
    userEmail = "matias.zwinger@protonmail.com";
  };

  fish = {
    enable = true;
    shellInit = "
      # Disable greeting
      set -U fish_greeting

      # Enable vi mode
      fish_vi_key_bindings
      set fish_cursor_default block
      set fish_cursor_insert line
      set fish_cursor_replace_one underscore
      set fish_cursor_visual block

      # Modify fzf.fish bindings
      fzf_configure_bindings --directory=\\cf --git_log=\\cg --git_status=\\cs --processes=\\cp
    ";
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
