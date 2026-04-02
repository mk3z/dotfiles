{
  lib,
  osConfig,
  pkgs,
  ...
}: let
  inherit (osConfig.mkez.core) homePersistDir;
  inherit (lib) mkIf;
  krbEnabled = osConfig.mkez.services.krb.enable;
  package =
    if krbEnabled
    then pkgs.openssh_gssapi.override {withKerberos = true;}
    else pkgs.openssh;
in {
  home = {
    persistence."${homePersistDir}".directories = [".ssh"];
    packages = [
      (pkgs.mosh.override {openssh = package;})
      pkgs.sshfs
    ];
  };

  programs.ssh = {
    enable = true;
    inherit package;
    matchBlocks = {
      # Default settings
      "*" =
        {
          forwardAgent = false;
          addKeysToAgent = "yes";
          compression = false;
          serverAliveInterval = 0;
          serverAliveCountMax = 3;
          hashKnownHosts = false;
          userKnownHostsFile = "~/.ssh/known_hosts";
          controlMaster = "auto";
          controlPath = "~/.ssh/master-%r@%n:%p";
          controlPersist = "no";
        }
        // mkIf osConfig.mkez.hardware.yubikey.ssh
        {identityAgent = "/run/user/1000/gnupg/S.gpg-agent.ssh";};
      nas = {
        forwardAgent = true;
      };
      "lxplus*" = mkIf krbEnabled {
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
