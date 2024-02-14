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
          helix.enable = true;
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
          helix.enable = true;
        };
      };
    };

    memory-alpha = mkHost {
      extraModules = with inputs.nixos-hardware.nixosModules; [
        common-pc
        common-pc-ssd
        common-cpu-amd
      ];
      systemConfig = {
        core = {
          hostname = "memory-alpha";
          server = true;
        };
        hardware.zfs.enable = true;
        services = {
          arr.enable = true;
          jellyfin.enable = true;
          ssh.enable = true;
        };
      };
    };

    nixos-iso = mkHost {
      extraModules = with inputs.nixos-hardware.nixosModules;
        [
          common-pc
        ]
        ++ [
          "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
        ];
      systemConfig = {
        core = {
          hostname = "nixos-iso";
          server = false;
        };
        user.noPassword = true;
      };

      userConfig = {
        editors = {
          helix.enable = true;
        };
      };
    };
  };
}
