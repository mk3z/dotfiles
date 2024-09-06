{
  inputs,
  mkHost,
  ...
}: {
  flake.nixosConfigurations = {
    bastion = mkHost {
      extraModules = with inputs.nixos-hardware.nixosModules; [
        common-pc
        common-pc-ssd
      ];

      systemConfig = {
        core = {
          hostname = "bastion";
          server = true;
          lanInterface = "enp1s0";
        };
        services = {
          headscale.enable = true;
          mailserver.enable = true;
          resolved.enable = true;
          ssh.enable = true;
          tailscale.enable = true;
          website.enable = true;
        };
      };
    };
  };
}
