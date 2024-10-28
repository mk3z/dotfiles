{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption;
  inherit (config.mkez.user) username;
in {
  options.mkez.virtualisation.libvirt.enable = mkEnableOption "Enable libvirt";
  config = {
    virtualisation.libvirtd.enable = true;
    users.users.${username}.extraGroups = ["libvirtd"];
  };
}
