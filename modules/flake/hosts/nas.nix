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
          lanInterface = "enp37s0";
          server = true;
        };
        hardware.zfs = {
          enable = true;
          unstable = false;
        };
        services = {
          arr.enable = true;
          blocky.enable = true;
          cross-seed.enable = true;
          earthwalker.enable = true;
          firefox-sync.enable = true;
          homeassistant.enable = true;
          jellyfin.enable = true;
          navidrome.enable = true;
          ssh.enable = true;
          radicale.enable = true;
          resolved.enable = true;
          syncthing.enable = true;
          tailscale.enable = true;
          transmission = {
            enable = true;
            downloadDir = "/media/downloads";
          };
          tubearchivist.enable = true;
          vaultwarden.enable = true;
          webdav.enable = true;
        };
        virtualisation = {
          podman.enable = true;
        };
      };
    };
  };
}
