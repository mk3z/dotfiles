{
  description = "mkez NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    utils.url =
      "github:ravensiris/flake-utils-plus/7a8d789d4d13e45d20e6826d7b2a1757d52f2e13";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "utils";
    };

    impermanence.url = "github:nix-community/impermanence";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    doom-emacs = {
      url = "github:nix-community/nix-doom-emacs";
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

    fish-ssh-agent = {
      url = "github:danhper/fish-ssh-agent";
      flake = false;
    };

    stylix.url = "github:danth/stylix";

    base16 = {
      url = "github:base16-project/base16-schemes";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, utils, agenix, home-manager, impermanence
    , emacs-overlay, copilot, fish-ssh-agent, stylix, ... }:
    let
      username = "matias";
      sysPersistDir = "/nix/persist";
    in utils.lib.mkFlake {
      inherit self inputs;

      channelsConfig.allowUnfree = true;

      sharedOverlays = [ emacs-overlay.overlay ];

      hostDefaults.modules = [
        home-manager.nixosModule
        impermanence.nixosModule
        agenix.nixosModules.default
        stylix.nixosModules.stylix
        ./common
        ./user
      ];

      hosts = {
        nixvm = {
          modules = [ ./hosts/nixvm ];
          extraArgs = {
            username = username;
            sysPersistDir = sysPersistDir;
            homePersistDir = sysPersistDir;
          };
          specialArgs = { inherit inputs; };
        };
      };
    };
}
