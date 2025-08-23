{
  lib,
  osConfig,
  pkgs,
  ...
}: let
  inherit (osConfig.mkez.core) homePersistDir;
  inherit (osConfig.mkez.user) homeDirectory;
  package =
    if osConfig.mkez.services.krb.enable
    then pkgs.openssh_gssapi.override {withKerberos = true;}
    else pkgs.openssh;
in {
  home = {
    persistence."${homePersistDir}${homeDirectory}".directories = [".ssh"];
    packages = [
      (pkgs.mosh.override {openssh = package;})
      pkgs.sshfs
    ];
  };

  programs.ssh = {
    enable = true;
    inherit package;
    addKeysToAgent = "yes";
    matchBlocks = {
      nas = {
        forwardAgent = true;
      };
      "lxplus*" = {
        user = "mzwinger";
        extraOptions = {
          GSSAPIAuthentication = "yes";
          GSSAPIDelegateCredentials = "yes";
          GSSAPITrustDns = "yes";
        };
      };
    };
  };

  programs.git.package = lib.mkForce (pkgs.git.override {openssh = package;});

  services.ssh-agent.enable = true;
}
