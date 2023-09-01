{ pkgs, ... }:

{
  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.zafiro-icons;
      name = "Zafiro-icons-Dark";
    };
  };
}
