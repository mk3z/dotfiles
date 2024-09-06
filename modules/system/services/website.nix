{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.headscale;
  domains = {
    "mkez.fi" = {};
    "zwinger.fi" = {};
  };
in {
  options.mkez.services.website.enable = mkEnableOption "Whether to enable personal website hosting";
  config = mkIf cfg.enable {
    services.nginx = {
      enable = true;

      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      virtualHosts =
        lib.mapAttrs (
          _: _: {
            forceSSL = true;
            enableACME = true;
            locations."/".return = "301 https://matias.zwinger.xyz";
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
