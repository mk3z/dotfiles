{
  pkgs,
  config,
  osConfig,
  ...
}: let
  inherit (osConfig.mkez.core) homePersistDir;
  inherit (osConfig.mkez.user) homeDirectory;
in {
  imports = [./colors.nix];

  xdg.configFile."neomutt/mailcap".text = ''
    text/html; ${pkgs.firefox}/bin/firefox %s
    text/html; ${pkgs.w3m}/bin/w3m -I %{charset} -T text/html; copiousoutput;
    application/pdf; ${pkgs.xdg-utils}/bin/xdg-open %s &
    image/*; ${pkgs.xdg-utils}/bin/xdg-open %s &
  '';

  home.persistence."${homePersistDir}${homeDirectory}".directories = [".local/share/mail"];

  programs = {
    mbsync = {
      enable = true;
      package = pkgs.isync.override {withCyrusSaslXoauth2 = true;};
    };

    msmtp.enable = true;
    notmuch = {
      enable = true;
      hooks.preNew = "${config.programs.mbsync.package}/bin/mbsync -a";
    };
    neomutt = {
      enable = true;
      sidebar.enable = true;
      vimKeys = true;
      sort = "reverse-date";

      extraConfig = ''
        set reverse_name
        set fast_reply
        set fcc_attach
        set forward_quote
        set sidebar_format='%D%?F? [%F]?%* %?N?%N/? %?S?%S?'
        set mail_check_stats
        set mailcap_path=${config.xdg.configHome}/neomutt/mailcap
        set mark_old = no
        set pgp_default_key = ${osConfig.mkez.user.key}
        auto_view text/html
      '';

      binds = [
        {
          map = ["pager"];
          key = "e";
          action = "previous-line";
        }
        {
          map = ["pager"];
          key = "n";
          action = "next-line";
        }

        {
          map = ["index"];
          key = "e";
          action = "previous-undeleted";
        }
        {
          map = ["index"];
          key = "n";
          action = "next-undeleted";
        }

        {
          map = ["index"];
          key = "i";
          action = "display-message";
        }
        {
          map = ["pager"];
          key = "i";
          action = "view-attachments";
        }
        {
          map = ["attach"];
          key = "i";
          action = "view-mailcap";
        }
        {
          map = ["pager" "attach"];
          key = "m";
          action = "exit";
        }
        {
          map = ["index"];
          key = "l";
          action = "limit";
        }
        {
          map = ["index"];
          key = "N";
          action = "toggle-new";
        }
        {
          map = ["index" "pager"];
          key = "\\Ce";
          action = "sidebar-prev";
        }
        {
          map = ["index" "pager"];
          key = "\\Cn";
          action = "sidebar-next";
        }
        {
          map = ["index" "pager"];
          key = "\\Co";
          action = "sidebar-open";
        }
      ];

      macros = [
        {
          map = ["index"];
          key = "o";
          action = "<shell-escape>mbsync -a<enter>";
        }
        {
          map = ["index"];
          key = "\\Cf";
          action = "<vfolder-from-query>";
        }
      ];
    };
  };
}
