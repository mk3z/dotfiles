{ config, lib, pkgs, inputs, homePersistDir, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit (inputs) impermanence doom-emacs;
      inherit homePersistDir;
    };
    users.matias = import ./user.nix "matias";
  };
}
