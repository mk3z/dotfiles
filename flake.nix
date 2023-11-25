{
  description = "mkez NixOS configuration";

  outputs = { self, nixpkgs, utils, ... }@inputs:
    # username needs to be defined here because it is used in user and system config
    let
      username = "matias";
      homeDirectory = "/home/${username}";
    in
    utils.lib.mkFlake {
      inherit self inputs;

      channelsConfig.allowUnfree = true;

      sharedOverlays = [
        inputs.nur.overlay
        inputs.emacs-overlay.overlay
        inputs.fenix.overlays.default
      ];

      hostDefaults.modules = [
        inputs.home-manager.nixosModule
        inputs.impermanence.nixosModule
        inputs.agenix.nixosModules.default
        inputs.stylix.nixosModules.stylix
        ./modules/system
      ];

      hosts = {
        slimbook =
          let homePersistDir = "/persist";
          in
          {
            modules = [
              ./hosts/slimbook

              # hardware
              ./modules/laptop.nix
              ./modules/amd.nix
              ./modules/amdgpu.nix
              ./modules/zfs.nix
              ./modules/bluetooth.nix

              # features
              ./modules/autoupgrade.nix
              ./modules/borg.nix
              ./modules/sound.nix
              ./modules/fonts.nix
              ./modules/keyring.nix
              ./modules/man.nix
              ./modules/theme.nix

              # programs
              ./modules/docker.nix
              ./modules/greetd.nix
              ./modules/mullvad.nix
              ./modules/podman.nix
              ./modules/steam.nix
              ./modules/syncthing.nix

              {
                home-manager =
                  {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    extraSpecialArgs = { inherit inputs username homeDirectory homePersistDir; };
                    users.${username} = import ./user;
                  };
              }
            ];

            extraArgs = {
              inherit username homeDirectory homePersistDir;
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
                in
                {
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
      "github:gytis-ivaskevicius/flake-utils-plus";

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
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nix-straight.url = "github:mk3z/nix-straight.el";
      };
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

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
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
