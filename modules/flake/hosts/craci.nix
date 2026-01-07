{
  inputs,
  mkHost,
  ...
}: {
  flake.nixosConfigurations = {
    craci = mkHost {
      extraModules = with inputs.nixos-hardware.nixosModules; [
        framework-13-7040-amd
      ];

      systemConfig = {
        core = {
          hostname = "craci";
        };
        user = {
          passwordFile = ../../../secrets/craci-password.age;
          email = "matias.zwinger@craci.com";
          key = "DC815132F8A2A2D1CF4C7A4E9C7594038C66DA99";
          keyFile = "craci";
        };
        hardware = {
          bluetooth.enable = true;
          bolt.enable = true;
          fprint.enable = true;
          laptop.enable = true;
          yubikey.enable = true;
          zsa.enable = true;
        };
        services = {
          printing.enable = true;
          resolved.enable = true;
        };
        programs = {
          kubernetes.enable = true;
          ydotool.enable = true;
        };
        virtualisation = {
          docker.enable = true;
          libvirt.enable = true;
          podman.enable = true;
        };
      };

      userConfig = {
        gui = {
          wm.primary = "niri";
          launcher.primary = "fuzzel";
        };
        programs = {
          chromium.enable = true;
          thunderbird.enable = true;
        };
        editors = {
          helix.enable = true;
        };
      };
    };
  };
}
