{
  inputs,
  mkHost,
  ...
}: {
  flake.nixosConfigurations = {
    slimbook = mkHost {
      extraModules = with inputs.nixos-hardware.nixosModules; [
        common-cpu-amd
        common-cpu-amd-pstate
        common-gpu-amd
        common-hidpi
      ];

      systemConfig = {
        core = {
          hostname = "slimbook";
          server = false;
        };
        hardware = {
          laptop.enable = true;
          zfs.enable = true;
          bluetooth.enable = true;
        };
        features = {
          adb.enable = true;
          kubernetes.enable = true;
          libvirt.enable = true;
        };
        services = {
          borg.enable = true;
          docker.enable = true;
          mullvad.enable = true;
          podman.enable = true;
          ratbag.enable = true;
          syncthing.enable = true;
          resolved.enable = true;
          tailscale.enable = true;
          waydroid.enable = true;
        };
        programs = {
          steam.enable = true;
        };
      };

      userConfig = {
        programs = {
          bitwig.enable = true;
          monero.enable = true;
          prism.enable = true;
        };
        editors = {
          helix.enable = true;
        };
      };
    };
  };
}
