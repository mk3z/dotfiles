{
  inputs,
  mkHost,
  ...
}: {
  flake.nixosConfigurations = {
    framework = mkHost {
      extraModules = with inputs.nixos-hardware.nixosModules; [
        framework-13-7040-amd
      ];

      systemConfig = {
        core = {
          hostname = "framework";
        };
        hardware = {
          bluetooth.enable = true;
          fprint.enable = true;
          laptop.enable = true;
          rtl-sdr.enable = true;
          yubikey.enable = true;
          zfs.enable = true;
          zsa.enable = true;
        };
        services = {
          borg.enable = true;
          mullvad.enable = true;
          ratbag.enable = true;
          printing.enable = true;
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
          chromium.enable = true;
          lutris.enable = true;
          monero.enable = true;
          prism.enable = true;
          thunderbird.enable = true;
        };
        editors = {
          helix.enable = true;
        };
      };
    };
  };
}
