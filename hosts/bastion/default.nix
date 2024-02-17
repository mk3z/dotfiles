{
  lib,
  config,
  ...
}: {
  imports = [./hardware-configuration.nix ./boot.nix ./decrypt.nix];

  system.stateVersion = "23.11";
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";

  networking = {
    hostName = config.mkez.core.hostname;
    hostId = "c34261c9";
    useDHCP = false;
    interfaces."enp1s0" = {
      ipv4.addresses = [
        {
          address = "95.217.11.68";
          prefixLength = 32;
        }
      ];
      ipv6.addresses = [
        {
          address = "2a01:4f9:c011:a051::1";
          prefixLength = 64;
        }
      ];
    };
    defaultGateway = "95.217.11.68";
    defaultGateway6 = {
      address = "fe80::1";
      interface = "enp1s0";
    };
  };
}
