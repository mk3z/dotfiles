{
  config,
  osConfig,
  pkgs,
  ...
}: let
  inherit (osConfig.mkez.user) realName;
in {
  accounts.email = {
    maildirBasePath = config.xdg.dataHome + "/mail";

    accounts = {
      personal = let
        address = "matias@zwinger.fi";
      in {
        msmtp.enable = true;

        inherit address;
        aliases = ["mkez@zwinger.fi" "abuse@zwinger.fi" "postmaster@zwinger.fi" "security@zwinger.fi"];
        imap.host = "mail.zwinger.fi";

        mbsync = {
          enable = true;
          create = "maildir";
          expunge = "maildir";
        };

        gpg = {
          encryptByDefault = true;
          signByDefault = true;
          inherit (config.mkez.core) key;
        };

        maildir.path = address;

        neomutt = {
          enable = true;
          extraMailboxes = ["Drafts" "Junk" "Trash" "Sent" "Archive"];
          extraConfig = ''
            # This together with `set reverse_name` allows automatically
            # determening the address from which to reply based on the
            # recipient of the original mail
            alternates mkez@zwinger.fi abuse@zwinger.fi postmaster@zwinger.fi security@zwinger.fi
          '';
        };

        notmuch = {
          enable = true;
          neomutt.enable = true;
        };

        passwordCommand = "${pkgs.rbw}/bin/rbw get ${address}";

        inherit realName;
        userName = address;
        primary = true;

        smtp = {
          host = "mail.zwinger.fi";
          port = 587;
          tls.useStartTls = true;
        };
      };
    };
  };
}
