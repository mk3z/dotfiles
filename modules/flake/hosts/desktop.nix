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
        };
        hardware = {
          yubikey.enable = true;
        };
        services = {
          flatpak.enable = true;
          mullvad.enable = true;
          ratbag.enable = true;
          resolved.enable = true;
          tailscale.enable = true;
        };
        programs = {
          adb.enable = true;
          kubernetes.enable = true;
          steam.enable = true;
        };
        virtualisation = {
          libvirt.enable = true;
          podman.enable = true;
          waydroid.enable = true;
        };
      };

      userConfig = {
        gui = {
          wm.primary = "hyprland";
        };
        programs = {
          bitwig.enable = true;
          lutris.enable = true;
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
