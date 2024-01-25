{inputs, ...}: let
  username = "matias";
  homeDirectory = "/home/${username}";
in {
  flake.nixosConfigurations = {
    slimbook = let
      inherit (inputs.nixpkgs.lib) nixosSystem;
      homePersistDir = "/persist";
    in
      nixosSystem {
        modules = [
          ./hosts/slimbook
          ./modules/system

          # external
          inputs.home-manager.nixosModule
          inputs.impermanence.nixosModule
          inputs.agenix.nixosModules.default
          inputs.stylix.nixosModules.stylix

          # hardware
          ./modules/laptop.nix
          ./modules/amd.nix
          ./modules/amdgpu.nix
          ./modules/zfs.nix
          ./modules/bluetooth.nix

          # features
          ./modules/borg.nix
          ./modules/sound.nix
          ./modules/fonts.nix
          ./modules/keyring.nix
          ./modules/libvirt.nix
          ./modules/man.nix
          ./modules/ratbag.nix
          ./modules/theme.nix

          # programs
          ./modules/docker.nix
          ./modules/greetd.nix
          ./modules/mullvad.nix
          ./modules/podman.nix
          ./modules/steam.nix
          ./modules/syncthing.nix

          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs username homeDirectory homePersistDir;
              };
              users.${username} = import ./user;
            };
          }
        ];

        specialArgs = {
          inherit inputs;
          inherit username homeDirectory homePersistDir;
          sysPersistDir = "/persist";
        };
      };
  };
}
