{inputs, ...}: rec {
  user = import ./user.nix {inherit inputs;};
  system = import ./system.nix {inherit user inputs;};
}
