{pkgs, ...}: {
  # Some basic system maintenance packages
  environment.systemPackages = with pkgs; [htop ncdu killall parted wget];
  programs.vim = {
    enable = true;
    defaultEditor = true;
  };

  # Console keymap
  console.packages = with pkgs; [colemak-dh];
  console.keyMap = "colemak_dh_iso_us";
}
