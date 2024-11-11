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
        };
        hardware = {
          bluetooth.enable = true;
          laptop.enable = true;
          rtl-sdr.enable = true;
          yubikey.enable = true;
          zfs.enable = true;
        };
        services = {
          borg.enable = true;
          mullvad.enable = true;
          ratbag.enable = true;
          resolved.enable = true;
          tailscale.enable = true;
        };
        programs = {
          adb.enable = true;
          flipperzero.enable = true;
          kubernetes.enable = true;
          steam.enable = true;
          ydotool.enable = true;
        };
        virtualisation = {
          docker.enable = true;
          libvirt.enable = true;
          podman.enable = true;
          waydroid.enable = true;
        };
      };

      userConfig = {
        gui = {
          wm.primary = "niri";
          launcher.primary = "fuzzel";
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
