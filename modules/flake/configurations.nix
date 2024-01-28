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
          ./../../hosts/slimbook
          ../system/common

          # external
          inputs.home-manager.nixosModule
          inputs.impermanence.nixosModule
          inputs.agenix.nixosModules.default
          inputs.stylix.nixosModules.stylix

          # hardware
          ../system/laptop.nix
          ../system/amd.nix
          ../system/amdgpu.nix
          ../system/zfs.nix
          ../system/bluetooth.nix

          # common features
          ../system/sound.nix
          ../system/fonts.nix
          ../system/keyring.nix
          ../system/man.nix
          ../system/theme.nix

          # features
          ../system/autoupgrade.nix
          ../system/borg.nix
          ../system/docker.nix
          ../system/greetd.nix
          ../system/libvirt.nix
          ../system/monero.nix
          ../system/mullvad.nix
          ../system/podman.nix
          ../system/ratbag.nix
          ../system/steam.nix
          ../system/syncthing.nix

          {
            hw = {
              laptop.enable = true;
              amd.enable = true;
              amdgpu.enable = true;
              zfs.enable = true;
              bluetooth.enable = true;
            };
            features = {
              autoupgrade.enable = false;
              borg.enable = true;
              docker.enable = false;
              libvirt.enable = true;
              monero.persist = true;
              mullvad.enable = true;
              podman.enable = true;
              ratbag.enable = true;
              steam.enable = true;
              syncthing.enable = true;
            };

            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs username homeDirectory homePersistDir;
              };
              users.${username} = import ../user;
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
