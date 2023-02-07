{
  description = "mkez NixOS configuration";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;

    utils.url = github:gytis-ivaskevicius/flake-utils-plus;

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "utils";
    };

    impermanence.url = github:nix-community/impermanence;

    nixos-hardware.url = github:NixOS/nixos-hardware;

    agenix = {
      url = github:ryantm/agenix;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    doom-emacs = {
      url = github:nix-community/nix-doom-emacs;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay = {
      url = github:nix-community/emacs-overlay;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    copilot = {
      url = github:zerolfx/copilot.el;
      flake = false;
    };

    stylix.url = github:danth/stylix;

    base16 = {
      url = github:base16-project/base16-schemes;
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      utils,
      agenix,
      home-manager,
      impermanence,
      emacs-overlay,
      copilot,
      stylix,
      ...
    }:
    utils.lib.mkFlake {
      inherit self inputs;

      channelsConfig.allowUnfree = true;

      sharedOverlays = [
        emacs-overlay.overlay
      ];

      hostDefaults.modules = [
        home-manager.nixosModule
        impermanence.nixosModule
        agenix.nixosModule
        stylix.nixosModules.stylix
        ./common
        ./user
      ];

      hosts = {
        nixvm = {
          modules = [
            ./hosts/nixvm
          ];
          extraArgs = rec {
            sysPersistDir = "/nix/persist";
            homePersistDir = sysPersistDir;
          };
          specialArgs = {
            inherit inputs;
          };
        };
      };
    };
}
