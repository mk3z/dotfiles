{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.headscale;
  domain = "mkez.fi";
in {
  options.mkez.services.website.enable = mkEnableOption "Whether to enable personal website hosting";
  config = mkIf cfg.enable {
    services.nginx = {
      enable = true;

      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      virtualHosts.${domain} = {
        forceSSL = true;
        enableACME = true;
        locations."/".return = "301 https://matias.zwinger.xyz";
      };
    };

    security.acme = {
      acceptTerms = true;
      defaults.email = "matias.zwinger@protonmail.com";
    };
  };
}
