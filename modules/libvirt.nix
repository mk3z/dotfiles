{ pkgs, username, ... }:

{
  virtualisation.libvirtd.enable = true;
  users.users.${username}.extraGroups = [ "libvirtd" ];
}
