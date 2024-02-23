{
  inputs,
  mkHost,
  ...
}: {
  flake.nixosConfigurations = {
    nas = mkHost {
      extraModules = with inputs.nixos-hardware.nixosModules; [
        common-pc
        common-pc-ssd
        common-cpu-amd
      ];

      systemConfig = {
        core = {
          hostname = "nas";
          server = true;
        };
        hardware.zfs = {
          enable = true;
          unstable = false;
        };
        services = {
          arr.enable = true;
          jellyfin.enable = true;
          mullvad.enable = true;
          mpd.enable = true;
          ssh.enable = true;
          resolved.enable = true;
          syncthing.enable = true;
          tailscale.enable = true;
          transmission = {
            enable = true;
            download-dir = "/media/downloads/complete";
            incomplete-dir = "/media/downloads/incomplete";
          };
        };
      };
    };
  };
}
