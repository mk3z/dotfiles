{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (config.mkez.core) hostname;
  inherit (config.mkez.user) email;
in {
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./gameserver.nix
    ./qtnfs3.nix
    ./vpn.nix
  ];

  system.stateVersion = "24.11";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  networking = {
    hostName = config.mkez.core.hostname;
    hostId = "4a49e359";
    useDHCP = lib.mkDefault true;
  };

  systemd.services.fs-mount.enable = false;

  powerManagement.powerUpCommands = ''
    ${pkgs.hdparm}/sbin/hdparm -B 64 /dev/sd{a,b,d}
    ${pkgs.hdparm}/sbin/hdparm -S 120 /dev/sd{a,b,d}
  '';

  # For bastion borg backups
  users.users.bastion = {
    group = "bastion";
    isSystemUser = true;
    shell = pkgs.bashInteractive;
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDwGyydra5JU3FSR8IqLUi/HDJJWGGdZCzcQPdqEdh4c"];
  };
  users.groups.bastion = {};
  environment.systemPackages = [pkgs.borgbackup];

  age.secrets.cloudflare_env = {
    file = ../../secrets/cloudflare.env.age;
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = email;

    certs."intra.mkez.fi" = {
      inherit (config.services.nginx) group;

      domain = "intra.mkez.fi";
      extraDomainNames = ["*.intra.mkez.fi"];
      dnsProvider = "cloudflare";
      dnsResolver = "konnor.ns.cloudflare.com";
      webroot = null;
      environmentFile = config.age.secrets.cloudflare_env.path;
    };
  };

  services.nginx = {
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts."${hostname}.intra.mkez.fi" = {
      forceSSL = true;
      useACMEHost = "intra.mkez.fi";
    };
  };
}
