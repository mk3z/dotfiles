{inputs, ...}: let
  utils = import ../../lib {inherit inputs;};
  inherit (utils.system) mkHost;
in {
  flake.nixosConfigurations = {
    slimbook = mkHost {
      extraModules = with inputs.nixos-hardware.nixosModules; [
        common-cpu-amd
        common-cpu-amd-pstate
        common-gpu-amd
        common-hidpi
      ];
      systemConfig = {
        core.hostname = "slimbook";
        hardware = {
          laptop.enable = true;
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
          dnscrypt.enable = true;
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
    desktop = mkHost {
      extraModules = with inputs.nixos-hardware.nixosModules; [
        common-pc
        common-pc-ssd
        common-cpu-amd
        common-gpu-amd
        common-hidpi
      ];
      systemConfig = {
        core.hostname = "desktop";
        features = {
          autoupgrade.enable = false;
          docker.enable = false;
          kubernetes.enable = true;
          libvirt.enable = true;
        };
        services = {
          borg.enable = false;
          dnscrypt.enable = true;
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
