{
  lib,
  config,
  ...
}: let
  jellyfinPort = config.mkez.services.jellyfin.port;
  domains = {
    "zwinger.fi" = {};
  };
in {
  services.nginx = {
    enable = true;
    virtualHosts =
      (lib.mapAttrs (
          _: _: {
            forceSSL = true;
            enableACME = true;
            locations."/".return = "301 https://mkez.fi";
          }
        )
        domains)
      // {
        "jellyfin.mkez.fi" = {
          enableACME = true;
          forceSSL = true;
          locations."/".proxyPass = "http://nas.intra.mkez.fi:${toString jellyfinPort}/jellyfin/";
        };
      };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = config.mkez.user.email;
  };
}
