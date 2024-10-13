{
  pkgs,
  config,
  ...
}: {
  programs.rbw = {
    enable = true;
    settings = {
      inherit (config.mkez.user) email;
      base_url = "https://nas.intra.mkez.fi/vaultwarden/";
      pinentry = pkgs.pinentry-curses;
    };
  };
}
