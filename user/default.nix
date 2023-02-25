{ config, lib, pkgs, inputs, username, homePersistDir, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs homePersistDir;
    };
    users.matias = import ./user.nix username;
  };
}
