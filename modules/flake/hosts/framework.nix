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
        user.extraPersistDirs = ["School"];
        hardware = {
          bluetooth.enable = true;
          bolt.enable = true;
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
          claude.enable = true;
          gcloud.enable = true;
          lutris.enable = true;
          monero.enable = true;
          prism.enable = true;
          spotify.enable = true;
          thunderbird.enable = true;
        };
        services = {
          kanshi.settings = [
            {
              profile = {
                name = "undocked";
                outputs = [
                  {
                    criteria = "eDP-1";
                    status = "enable";
                    mode = "2880x1920@120";
                    position = "0,0";
                    scale = 2.0;
                    adaptiveSync = true;
                  }
                ];
              };
            }
            {
              profile = {
                name = "docked";
                outputs = [
                  {
                    criteria = "eDP-1";
                    status = "disable";
                  }
                  {
                    criteria = "LG Electronics LG TV SSCR2 0x01010101";
                    status = "enable";
                    mode = "3840x2160@60.000";
                    position = "0,0";
                    scale = 2.0;
                    adaptiveSync = true;
                  }
                ];
              };
            }
          ];
        };
        editors = {
          helix.enable = true;
        };
      };
    };
  };
}
