{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.headscale;
  domains = {
    "zwinger.fi" = {};
  };
in {
  options.mkez.services.website.enable = mkEnableOption "Whether to enable personal website hosting";
  config = mkIf cfg.enable {
    services.nginx = {
      enable = true;
      virtualHosts =
        lib.mapAttrs (
          _: _: {
            forceSSL = true;
            enableACME = true;
            locations."/".return = "301 https://mkez.fi";
          }
        )
        domains;
    };

    security.acme = {
      acceptTerms = true;
      defaults.email = config.mkez.user.email;
    };
  };
}
