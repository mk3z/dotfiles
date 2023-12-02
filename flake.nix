{
  description = "mkez NixOS configuration";

  outputs = {
    nixpkgs,
    flake-parts,
    devenv,
    ...
  } @ inputs: let
    # username needs to be defined here because it is used in user and system config
    username = "matias";
    homeDirectory = "/home/${username}";
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      imports = [
        inputs.devenv.flakeModule
      ];

      flake.nixosConfigurations = {
        slimbook = let
          inherit (inputs.nixpkgs.lib) nixosSystem;
          homePersistDir = "/persist";
        in
          nixosSystem {
            modules = [
              ./hosts/slimbook
              ./modules/system

              # external
              inputs.home-manager.nixosModule
              inputs.impermanence.nixosModule
              inputs.agenix.nixosModules.default
              inputs.stylix.nixosModules.stylix

              # hardware
              ./modules/laptop.nix
              ./modules/amd.nix
              ./modules/amdgpu.nix
              ./modules/zfs.nix
              ./modules/bluetooth.nix

              # features
              ./modules/borg.nix
              ./modules/sound.nix
              ./modules/fonts.nix
              ./modules/keyring.nix
              ./modules/libvirt.nix
              ./modules/man.nix
              ./modules/ratbag.nix
              ./modules/theme.nix

              # programs
              ./modules/docker.nix
              ./modules/greetd.nix
              ./modules/mullvad.nix
              ./modules/podman.nix
              ./modules/steam.nix
              ./modules/syncthing.nix

              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = {
                    inherit inputs username homeDirectory homePersistDir;
                  };
                  users.${username} = import ./user;
                };
              }
            ];

            extraArgs = {
              inherit username homeDirectory homePersistDir;
              sysPersistDir = "/persist";
            };
            specialArgs = {inherit inputs;};
          };
      };

      perSystem = {
        system,
        config,
        pkgs,
        ...
      }: {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        devenv.shells.default = {
          pre-commit = {
            hooks = {
              alejandra.enable = true;
              deadnix.enable = true;
              nil.enable = true;
              statix.enable = true;
            };
            settings = {
              deadnix = {
                edit = true;
                hidden = true;
              };
            };
          };
        };
      };
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nur.url = "github:nix-community/NUR";

    devenv.url = "github:cachix/devenv";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nix-straight = {
      url = "github:mk3z/nix-straight.el";
      flake = false;
    };

    doom-emacs = {
      url = "github:ckiee/nix-doom-emacs/move-nix-straight-in";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        # NOTE: Remove this when upstream nix-straight.el implements pgtk support.
        nix-straight.follows = "nix-straight";
      };
    };

    copilot = {
      url = "github:zerolfx/copilot.el";
      flake = false;
    };

    ob-ammonite = {
      url = "github:zwild/ob-ammonite";
      flake = false;
    };

    ammonite-term-repl = {
      url = "github:zwild/ammonite-term-repl";
      flake = false;
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fish-ssh-agent = {
      url = "github:danhper/fish-ssh-agent";
      flake = false;
    };

    fish-git = {
      url = "github:lewisacidic/fish-git-abbr";
      flake = false;
    };

    fish-kubectl = {
      url = "github:DrPhil/kubectl-fish-abbr";
      flake = false;
    };

    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
