{ pkgs, lib, inputs }:

{
  home-manager.enable = true;

  ssh = { enable = true; };

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

  nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  starship = import ./starship.nix;

  waybar = import ./waybar.nix;
}
