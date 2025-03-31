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
          yubikey.enable = true;
          zfs.enable = true;
        };
        services = {
          mullvad.enable = true;
          resolved.enable = true;
          tailscale.enable = true;
        };
        programs = {
          adb.enable = true;
          steam.enable = true;
          ydotool.enable = true;
        };
      };

      userConfig = {
        gui = {
          wm.primary = "niri";
          launcher.primary = "fuzzel";
        };
        editors = {
          helix.enable = true;
        };
      };
    };
  };
}
