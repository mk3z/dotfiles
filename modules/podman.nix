{ pkgs, ... }:

{
  virtualisation.podman = {
    enable = true;
    autoPrune.enable = true;
    defaultNetwork.settings.dns_enabled = true;
    extraPackages = with pkgs; [ zfs ];
  };

  environment.systemPackages = with pkgs; [ podman-compose ];
}
