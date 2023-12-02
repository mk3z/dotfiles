{pkgs, ...}: {
  xdg = {
    portal = {
      wlr.enable = true;
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];
    };
  };
}
