{inputs, ...}: let
  utils = import ../../../lib {inherit inputs;};
  inherit (utils.system) mkHost;
in {
  imports = [
    (import ./bastion.nix {inherit inputs mkHost;})
    (import ./desktop.nix {inherit inputs mkHost;})
    (import ./framework.nix {inherit inputs mkHost;})
    (import ./nas.nix {inherit inputs mkHost;})
    (import ./nixos-iso.nix {inherit inputs mkHost;})
    (import ./slimbook.nix {inherit inputs mkHost;})
  ];
}
