{
  description = "mkez NixOS configuration";

  outputs = {
    self,
    nixpkgs,
    utils,
    devenv,
    ...
  } @ inputs: let
    # username needs to be defined here because it is used in user and system config
    username = "matias";
    homeDirectory = "/home/${username}";
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
  in
    utils.lib.mkFlake {
      inherit self inputs;

      supportedSystems = ["x86_64-linux"];

      channelsConfig.allowUnfree = true;

      sharedOverlays = [inputs.nur.overlay inputs.fenix.overlays.default];

      hostDefaults.modules = [
        inputs.home-manager.nixosModule
        inputs.impermanence.nixosModule
        inputs.agenix.nixosModules.default
        inputs.stylix.nixosModules.stylix
        ./modules/system
      ];

      hosts = {
        slimbook = let
          homePersistDir = "/persist";
        in {
          modules = [
            ./hosts/slimbook

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

      devShell.x86_64-linux = devenv.lib.mkShell {
        inherit inputs pkgs;
        modules = [
          {pre-commit.hooks.alejandra.enable = true;}
        ];
      };
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nur.url = "github:nix-community/NUR";

    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";

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

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
