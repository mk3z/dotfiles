{
  inputs,
  config,
  ...
}: let
  inherit (config.mkez.core) sysPersistDir;
in {
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    # Make `nix run nixpkgs#...` use the same nixpkgs as the one used by this flake.
    registry.nixpkgs.flake = inputs.nixpkgs;

    settings = {
      allowed-users = ["@wheel"];
      trusted-users = ["@wheel"];
      experimental-features = ["nix-command" "flakes" "auto-allocate-uids"];
      auto-optimise-store = true;
      substituters = ["https://nix-community.cachix.org"];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };

    distributedBuilds = true;

    buildMachines =
      if (config.mkez.core.hostname != "nas" && config.mkez.services.tailscale.enable)
      then [
        {
          hostName = "nas.intra.mkez.fi";
          sshUser = "mkez";
          sshKey = "/root/.ssh/buildkey";
          system = "x86_64-linux";
          protocol = "ssh-ng";
          maxJobs = 16; # Number of threads
          speedFactor = 1;
          supportedFeatures = ["nixos-test" "benchmark" "big-parallel"];
        }
      ]
      else [];

    extraOptions = ''
      builders-use-substitutes = true
    '';
  };

  # For storing build key
  environment.persistence."${sysPersistDir}".directories = ["/root/.ssh"];

  # Make `nix repl '<nixpkgs>'` use the same nixpkgs as the one used by this flake.
  environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";
  nix.nixPath = ["/etc/nix/inputs"];
}
