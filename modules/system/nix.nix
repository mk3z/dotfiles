{ inputs, ... }: {
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    # Make `nix run nixpkgs#...` use the same nixpkgs as the one used by this flake.
    registry.nixpkgs.flake = inputs.nixpkgs;

    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      substituters = [ "https://nix-community.cachix.org" ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  # Make `nix repl '<nixpkgs>'` use the same nixpkgs as the one used by this flake.
  environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";
  nix.nixPath = [ "/etc/nix/inputs" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
