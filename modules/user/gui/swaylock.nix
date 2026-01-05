{lib, ...}: {
  stylix.targets.swaylock.useWallpaper = false;

  programs.swaylock = {
    enable = true;
    settings = {
      font = "monospace";
      font-size = 18;
      color = lib.mkForce "000000";
    };
  };
}
