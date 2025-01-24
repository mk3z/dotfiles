{lib, ...}: {
  stylix.targets.swaylock.useImage = false;

  programs.swaylock = {
    enable = true;
    settings = {
      font = "monospace";
      font-size = 18;
      color = lib.mkForce "000000";
    };
  };
}
