{
  pkgs,
  config,
  ...
}: let
  inherit (config.mkez.core) server;
in {
  # Some basic system maintenance packages
  environment.systemPackages = with pkgs; [
    htop
    iotop
    ncdu
    killall
    parted
    wget
  ];
  programs.vim = {
    enable = true;
    defaultEditor = true;
  };

  # Console keymap
  console =
    if server
    then {}
    # Server should have US layout for ease of operation over online KVM inferfaces.
    else {
      packages = with pkgs; [colemak-dh];
      keyMap = "colemak_dh_iso_us";
    };
}
