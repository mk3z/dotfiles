{
  config,
  osConfig,
  pkgs,
  ...
}: let
  inherit (osConfig.mkez.user) realName;
  inherit (osConfig.mkez.core) homePersistDir;
  inherit (osConfig.mkez.user) homeDirectory;
  mkSchool = {
    address,
    userName ? address,
  }: {
    inherit address userName realName;
    msmtp = {
      enable = true;
      extraConfig.auth = "xoauth2";
    };

    # NOTE: setup the oauth with the mutt_oauth2.py script
    # https://www.vanormondt.net/~peter/blog/2021-03-16-mutt-office365-mfa.html
    # Using the (old) Thunderbird oauth app
    # client_id = 08162f7c-0fd2-4200-a84a-f25a4db0b584
    # client_secret = TxRBilcHdC6WGBee]fs?QR:SJ8nI[g82
    # use -t $PASSWORD_STORE_DIR/$address.gpg to get the path correct (for pass)
    passwordCommand = let
      python = "${pkgs.python3}/bin/python3";
      mutt_oauth2 = "${pkgs.neomutt}/share/neomutt/oauth2/mutt_oauth2.py";
    in "${python} ${mutt_oauth2} --encryption-pipe 'gpg -e -r ${address}' ${config.xdg.dataHome}/oauth/${address}.gpg";

    flavor = "outlook.office365.com";

    mbsync = {
      enable = true;
      create = "maildir";
      expunge = "maildir";
      extraConfig.account.AuthMechs = "XOAUTH2";
    };

    gpg = {
      encryptByDefault = true;
      signByDefault = true;
    };

    maildir.path = address;

    folders = {
      sent = "Sent Items";
      trash = "Deleted Items";
    };

    neomutt = {
      enable = true;
      extraMailboxes = ["Drafts" "Deleted Items" "Sent Items"];
    };

    notmuch = {
      enable = true;
      neomutt.enable = true;
    };
  };
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

      aalto = mkSchool {
        address = "matias.zwinger@aalto.fi";
      };
    };
  };

  home.persistence."${homePersistDir}${homeDirectory}".directories = [".local/share/oauth"];
}
