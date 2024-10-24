{
  pkgs,
  osConfig,
  ...
}: {
  programs.rbw = {
    enable = true;
    settings = {
      inherit (osConfig.mkez.user) email;
      base_url = "https://nas.intra.mkez.fi/vaultwarden/";
      pinentry = pkgs.pinentry-curses;
    };
  };
}
