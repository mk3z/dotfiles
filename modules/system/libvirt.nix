{
  lib,
  username,
  ...
}: let
  inherit (lib) mkEnableOption;
in {
  options.features.libvirt.enable = mkEnableOption "Enable libvirt";
  config = {
    virtualisation.libvirtd.enable = true;
    users.users.${username}.extraGroups = ["libvirtd"];
  };
}
