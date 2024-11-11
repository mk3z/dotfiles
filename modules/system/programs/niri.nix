{
  inputs,
  config,
  ...
}: let
  inherit (config.mkez.user) username;
  wm =
    if config.home-manager.users ? mkez
    then config.home-manager.users.${username}.mkez.gui.wm
    else {niri.enable = false;};
in {
  imports = [inputs.niri.nixosModules.niri];

  nixpkgs.overlays = [inputs.niri.overlays.niri];
  programs.niri.enable = wm.niri.enable;
}
