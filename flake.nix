{
  description = "mkez NixOS configuration";

  outputs = { self, nixpkgs, utils, ... }@inputs:
    # username needs to be defined here because it is used in user and system config
    let username = "matias";
    in utils.lib.mkFlake {
      inherit self inputs;

      channelsConfig.allowUnfree = true;

      sharedOverlays = [ inputs.nur.overlay inputs.emacs-overlay.overlay ];

      hostDefaults.modules = [
        inputs.home-manager.nixosModule
        inputs.impermanence.nixosModule
        inputs.agenix.nixosModules.default
        inputs.stylix.nixosModules.stylix
        ./modules/system
      ];

      hosts = {
        slimbook = {
          modules = [
            ./hosts/slimbook

            # hardware
            ./modules/laptop.nix
            ./modules/amdgpu.nix
            ./modules/zfs.nix
            ./modules/bluetooth.nix

            # features
            ./modules/sound.nix
            ./modules/fonts.nix
            ./modules/keyring.nix

            # programs
            ./modules/greetd.nix
            ./modules/mullvad.nix

            {
              home-manager =
                let homePersistDir = "/persist";
                in {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = { inherit inputs username homePersistDir; };
                  users.${username} = import ./user;
                };
            }
          ];

          extraArgs = {
            inherit username;
            sysPersistDir = "/persist";
          };
          specialArgs = { inherit inputs; };
        };

        nixvm = {
          modules = [
            ./hosts/nixvm

            # features
            ./modules/sound.nix
            ./modules/fonts.nix

            # programs
            ./modules/greetd.nix

            {
              home-manager =
                let homePersistDir = "/nix/persist";
                in {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = { inherit inputs homePersistDir; };
                  users.${username} = import ./user username;
                };
            }
          ];

          extraArgs = {
            inherit username;
            sysPersistDir = "/nix/persist";
          };
          specialArgs = { inherit inputs; };
        };
      };

      # TODO: Make it work with other platforms
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;

    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nur.url = "github:nix-community/NUR";

    utils.url =
      "github:ravensiris/flake-utils-plus/7a8d789d4d13e45d20e6826d7b2a1757d52f2e13";

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

    doom-emacs = {
      url = "github:librephoenix/nix-doom-emacs/pgtk-patch";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
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

    fish-ssh-agent = {
      url = "github:danhper/fish-ssh-agent";
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
