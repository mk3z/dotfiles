{ pkgs, lib, inputs }:

{
  home-manager.enable = true;

  ssh = { enable = true; };

  doom-emacs = {
    enable = false;
    doomPrivateDir = ./doom.d;
    emacsPackage = pkgs.emacs-pgtk;
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

      magit-delta = super.magit-delta.overrideAttrs
        (esuper: { buildInputs = esuper.buildInputs ++ [ pkgs.git ]; });

      ob-mermaid = super.ob-mermaid.overrideAttrs (esuper: {
        buildInputs = esuper.buildInputs ++ [ pkgs.nodePackages.mermaid-cli ];
      });

      copilot = self.trivialBuild {
        pname = "copilot";
        src = inputs.copilot;
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

  fish = import ./fish.nix { inherit inputs; };

  foot = {
    enable = true;
    server.enable = true;
    settings = {
      main.font = lib.mkForce "monospace:size=10";
      main.pad = "2x2";
      scrollback.lines = 10000;
      mouse.hide-when-typing = "yes";
    };
  };

  fzf.enable = true;

  jq.enable = true;

  lsd = {
    enable = true;
    enableAliases = true;
  };

  mpv.enable = true;

  starship = import ./starship.nix;

  waybar = {
    enable = true;

    settings = {
      mainBar = {
        position = "bottom";
        height = 16;
        modules-left = [ "hyprland/workspaces" "hyprland/window" ];
        modules-right = [ "network" "battery" "clock" ];

        "clock" = {
          interval = 1;
          format = "{:%a %F %T}";
        };

        "network" = {
          interval = 10;
          format-ethernet = "{ipaddr}/{cidr}";
          format-wifi =
            "{essid} {frequency}GHz {signalStrength}% {ipaddr}/{cidr}";
          format-disconnected = "disconnected";
        };

        "battery" = {
          interval = 10;
          format = "{capacity}% {time}";
        };

      };
    };

    style = ''
      * {
        font-family: "Monospace";
        font-size: 10px;
        opacity: 0.85;
        min-height: 0;
        border-bottom: none;
      }

      window#waybar {
        padding: 0;
        margin: 0;
      }

      #clock, #battery, #network {
        border-left: 1px solid;
        padding: 0 4px;
      }

      #window {
        padding: 0 4px;
      }

      #workspaces button {
        padding: 0;
        border: 1px solid;
        border-radius: 0;
      }
    '';
  };
}
