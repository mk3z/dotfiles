{
  description = "mkez NixOS configuration";

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

  outputs =
    inputs@{ self
    , nixpkgs
    , nur
    , utils
    , agenix
    , home-manager
    , impermanence
    , emacs-overlay
    , copilot
    , fish-ssh-agent
    , stylix
    , ...
    }:
    let username = "matias";
    in
    utils.lib.mkFlake {
      inherit self inputs;

      channelsConfig.allowUnfree = true;

      sharedOverlays = [ nur.overlay emacs-overlay.overlay ];

      hostDefaults.modules = [
        home-manager.nixosModule
        impermanence.nixosModule
        agenix.nixosModules.default
        stylix.nixosModules.stylix
        ./system
        ./user
      ];

      hosts = {
        slimbook = {
          modules =
            [ ./hosts/slimbook ./modules/laptop.nix ./modules/bluetooth.nix ];
          extraArgs = {
            inherit username;
            sysPersistDir = "/persist";
            homePersistDir = "/persist";
          };
          specialArgs = { inherit inputs; };
        };

        nixvm = {
          modules = [ ./hosts/nixvm ];
          extraArgs = {
            inherit username;
            sysPersistDir = "/nix/persist";
            homePersistDir = "/nix/persist";
          };
          specialArgs = { inherit inputs; };
        };
      };

      # TODO: Make it work with other platforms
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;

    };
}
