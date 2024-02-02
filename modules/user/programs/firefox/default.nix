{
  pkgs,
  homePersistDir,
  homeDirectory,
  ...
}: {
  imports = [
    # Cool plugin but scroll is bad
    #./tridactyl.nix
  ];

  home.persistence."${homePersistDir}${homeDirectory}".directories = [".mozilla/firefox"];

  xdg.mimeApps = {
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
    };
  };

  programs.firefox = {
    enable = true;
    profiles.default = {
      name = "default";
      id = 0;
      settings = import ./settings.nix;

      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        darkreader
        kristofferhagen-nord-theme
        privacy-badger
        privacy-redirect
        rust-search-extension
        sidebery
        skip-redirect
        sponsorblock
        ublock-origin
        user-agent-string-switcher
        vimium
        web-archives
      ];

      containers = {
        personal = {
          id = 0;
          color = "blue";
          icon = "fingerprint";
        };

        school = {
          id = 1;
          color = "yellow";
          icon = "fruit"; # Because teachers eat apples
        };

        shopping = {
          id = 2;
          color = "pink";
          icon = "cart";
        };

        banking = {
          id = 3;
          color = "green";
          icon = "dollar";
        };
      };

      search = {
        force = true;
        default = "DuckDuckGo";
        engines = {
          "Amazon.de" = {
            urls = [{template = "https://www.amazon.de/s?k={searchTerms}";}];
            definedAliases = [":az"];
          };

          "Arch Wiki" = {
            urls = [
              {
                template = "https://wiki.archlinux.org/index.php?search={searchTerms}";
              }
            ];
            definedAliases = [":aw"];
          };

          "DuckDuckGo" = {
            urls = [{template = "https://duckduckgo.com/?q={searchTerms}";}];
            definedAliases = [":d"];
          };

          "Home Manager" = {
            urls = [
              {
                template = "https://mipmip.github.io/home-manager-option-search/?query={searchTerms}";
              }
            ];
            definedAliases = [":hm"];
          };

          "Nix Options" = {
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = [":no"];
          };

          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = [":np"];
          };

          "NixOS Wiki" = {
            urls = [
              {
                template = "https://nixos.wiki/index.php?search={searchTerms}";
              }
            ];
            definedAliases = [":nw"];
          };

          "Noogle" = {
            urls = [
              {
                template = "https://noogle.dev/q?term={searchTerms}";
              }
            ];
            definedAliases = [":ng"];
          };

          "Hoogle" = {
            urls = [
              {
                template = "https://hoogle.haskell.org/?hoogle={searchTerms}&scope=set%3Astackage";
              }
            ];
            definedAliases = [":hg"];
          };

          "Wikipedia" = {
            urls = [
              {
                template = "https://en.wikipedia.org/wiki/Special:Search?search={searchTerms}";
              }
            ];
            definedAliases = [":w"];
          };

          "Wikipedia (de)" = {
            urls = [
              {
                template = "https://de.wikipedia.org/wiki/Special:Search?search={searchTerms}";
              }
            ];
            definedAliases = [":wd"];
          };

          "Wikipedia (fi)" = {
            urls = [
              {
                template = "https://fi.wikipedia.org/wiki/Special:Search?search={searchTerms}";
              }
            ];
            definedAliases = [":wf"];
          };

          "YouTube" = {
            urls = [
              {
                template = "https://www.youtube.com/results?search_query={searchTerms}";
              }
            ];
            definedAliases = [":yt"];
          };
        };
      };

      userChrome = ''
        @namespace url("http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul");
        #TabsToolbar { visibility: collapse !important; }
        #sidebar-header { display: none; }
        #navigator-toolbox {
          font-family: monospace !important;
          font-size: 12px !important;
        }
      '';
    };
  };
}
