{pkgs, ...}: {
  programs.rbw = {
    enable = true;
    settings = {
      email = "matias@zwinger.xyz";
      base_url = "https://zwinger.xyz/vaultwarden/";
      pinentry = pkgs.pinentry-curses;
    };
  };
}
