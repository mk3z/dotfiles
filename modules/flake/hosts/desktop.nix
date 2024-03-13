{
  inputs,
  mkHost,
  ...
}: {
  flake.nixosConfigurations = {
    desktop = mkHost {
      extraModules = with inputs.nixos-hardware.nixosModules; [
        common-pc
        common-pc-ssd
        common-cpu-amd
        common-gpu-amd
        common-hidpi
      ];
      systemConfig = {
        core = {
          hostname = "desktop";
          server = false;
        };
        features = {
          adb.enable = true;
          kubernetes.enable = true;
          libvirt.enable = true;
        };
        services = {
          mullvad.enable = true;
          podman.enable = true;
          ratbag.enable = true;
          resolved.enable = true;
          syncthing.enable = true;
        };
        programs = {
          steam.enable = true;
        };
      };

      userConfig = {
        programs = {
          bitwig.enable = true;
          monero.enable = true;
        };
        editors = {
          helix.enable = true;
        };
      };
    };
  };
}