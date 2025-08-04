{
  lib,
  config,
  ...
}: let
  inherit (config.mkez.user) email;
in {
  imports = [
    ./boot.nix
    ./decrypt.nix
    ./hardware-configuration.nix
    ./network.nix
    ./nginx.nix
  ];

  services.nginx = {
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = email;
  };

  system.stateVersion = "25.05";
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
