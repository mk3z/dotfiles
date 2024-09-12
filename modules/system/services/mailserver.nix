{
  lib,
  config,
  inputs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.services.mailserver;
  inherit (config.mkez.core) sysPersistDir;
in {
  options.mkez.services.mailserver.enable = mkEnableOption "Whether to enable the mailserver";

  imports = [inputs.mailserver.nixosModule];

  config = mkIf cfg.enable {
    age.secrets.email-password.file = ../../../secrets/email-password.age;

    mailserver = {
      enable = true;
      fqdn = "mail.zwinger.fi";
      domains = ["zwinger.fi"];

      # A list of all login accounts. To create the password hashes, use
      # nix-shell -p mkpasswd --run 'mkpasswd -sm bcrypt'
      loginAccounts = {
        "matias@zwinger.fi" = {
          hashedPasswordFile = config.age.secrets.email-password.path;
          aliases = ["mkez@zwinger.fi" "abuse@zwinger.fi" "postmaster@zwinger.fi" "security@zwinger.fi"];
        };
      };

      mailboxes = {
        Drafts = {
          auto = "subscribe";
          specialUse = "Drafts";
        };
        Junk = {
          auto = "subscribe";
          specialUse = "Junk";
        };
        Sent = {
          auto = "subscribe";
          specialUse = "Sent";
        };
        Archive = {
          auto = "subscribe";
          specialUse = "Archive";
        };
        Trash = {
          auto = "subscribe";
          specialUse = "Trash";
        };
      };

      certificateScheme = "acme-nginx";

      borgbackup = {
        enable = true;
        repoLocation = "bastion@nas.intra.mkez.fi:/backup/mail";
        cmdPreexec = ''
          export BORG_RSH="ssh -i ${config.mailserver.mailDirectory}/.ssh/id_ed25519"
        '';
      };
    };

    security.acme.acceptTerms = true;

    environment.persistence."${sysPersistDir}" = {
      directories = with config.mailserver; [
        mailDirectory
        sieveDirectory
        dkimKeyDirectory
      ];
    };
  };
}
