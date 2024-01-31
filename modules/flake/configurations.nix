{inputs, ...}: let
  utils = import ../../lib {inherit inputs;};
in {
  flake.nixosConfigurations = {
    slimbook = utils.system.mkHost {
      systemConfig = {
        core.hostname = "slimbook";
        hardware = {
          laptop.enable = true;
          amd.enable = true;
          amdgpu.enable = true;
          zfs.enable = true;
          bluetooth.enable = true;
        };
        features = {
          autoupgrade.enable = false;
          docker.enable = false;
          kubernetes.enable = true;
          libvirt.enable = true;
        };
        services = {
          borg.enable = true;
          monero.persist = true;
          mullvad.enable = true;
          podman.enable = true;
          ratbag.enable = true;
          syncthing.enable = true;
        };
        programs = {
          steam.enable = true;
        };
      };

      userConfig = {
        programs = {
          bitwig.enable = true;
        };
        editors = {
          doom.enable = false;
          helix.enable = true;
          nvim.enable = false;
        };
      };
    };
  };
}
