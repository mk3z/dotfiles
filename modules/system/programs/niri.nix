{
  inputs,
  config,
  ...
}: let
  inherit (config.mkez.user) username;
in {
  imports = [inputs.niri.nixosModules.niri];
  programs.niri.enable =
    if config.home-manager.users ? mkez
    then config.home-manager.users.${username}.mkez.gui.wm.niri.enable
    else false;
}
