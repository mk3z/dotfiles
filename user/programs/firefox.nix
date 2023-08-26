{ pkgs }:
{
  enable = true;
  profiles.default = {
    name = "default";
    id = 0;

    extensions =
      with pkgs.nur.repos.rycee.firefox-addons;
      [
        bitwarden
        darkreader
        kristofferhagen-nord-theme
        privacy-badger
        privacy-redirect
        skip-redirect
        tree-style-tab
        ublock-origin
        user-agent-string-switcher
        vimium
      ];

    settings = {
      # Mostly from https://github.com/arkenfox/user.js/blob/master/user.js

      # Startup
      "browser.aboutConfig.showWarning" = false;
      "browser.startup.page" = 0;
      "browser.startup.homepage" = "about:blank";
      "browser.newtabpage.enabled" = false;
      "browser.newtabpage.activity-stream.showSponsored" = false;
      "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

      # Geolocation, i18n
      "geo.provider.use_gpsd" = false;
      "geo.provider.use_geoclue" = false;
      "intl.accept_languages" = "en-US, en";
      "javascript.use_us_english_locale" = true;

      # Quiet
      "extensions.getAddons.showPane" = false;
      "extensions.htmlaboutaddons.recommendations.enabled" = false;
      "browser.discovery.enabled" = false;

      # Telemetry
      "datareporting.policy.dataSubmissionEnabled" = false;
      "datareporting.healthreport.uploadEnabled" = false;
      "toolkit.telemetry.unified" = false;
      "toolkit.telemetry.enabled" = false;
      "toolkit.telemetry.server" = "data:,";
      "toolkit.telemetry.archive.enabled" = false;
      "toolkit.telemetry.newProfilePing.enabled" = false;
      "toolkit.telemetry.shutdownPingSender.enabled" = false;
      "toolkit.telemetry.updatePing.enabled" = false;
      "toolkit.telemetry.bhrPing.enabled" = false;
      "toolkit.telemetry.firstShutdownPing.enabled" = false;
      "toolkit.telemetry.coverage.opt-out" = true;
      "toolkit.coverage.opt-out" = true;
      "toolkit.coverage.endpoint.base" = "";
      "browser.ping-centre.telemetry" = false;
      "browser.newtabpage.activity-stream.feeds.telemetry" = false;
      "browser.newtabpage.activity-stream.telemetry" = false;

      # Studies
      "app.shield.optoutstudies.enabled" = false;
      "app.normandy.enabled" = false;
      "app.normandy.api_url" = "";

      # Crash reports
      "breakpad.reportURL" = "";
      "browser.tabs.crashReporting.sendReport" = false;
      "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;

      # Other
      "captivedetect.canonicalURL" = "";
      "network.captive-portal-service.enabled" = false;
      "network.connectivity-service.enabled" = false;

      # Safe browsing
      "browser.safebrowsing.downloads.remote.enabled" = false;

      # Block implicit outbound
      "network.prefetch-next" = false;
      "network.dns.disablePrefetch" = true;
      "network.predictor.enabled" = false;
      "network.predictor.enable-prefetch" = false;
      "network.http.speculative-parallel-limit" = 0;
      "network.places.speculativeConnect.enabled" = false;

      # Networking
      "network.proxy.socks_remote_dns" = true;
      "network.file.disable_unc_paths" = true;
      "network.gio.supported-protocols" = "";

      # Search
      "browser.fixup.alternate.enabled" = false;
      "browser.search.suggest.enabled" = false;
      "browser.urlbar.suggest.searches" = false;
      "browser.urlbar.speculativeConnect.enabled" = false;
      "browser.urlbar.dnsResolveSingleWordsAfterSearch" = 0;
      "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
      "browser.urlbar.suggest.quicksuggest.sponsored" = false;
      "browser.formfill.enable" = false;

      # Passwords
      "signon.autofillForms" = false;
      "signon.formlessCapture.enabled" = false;

      # Cache
      "browser.privatebrowsing.forceMediaMemoryCache" = true;
      "media.memory_cache_max_size" = 65536;

      # TLS
      "security.ssl.require_safe_negotiation" = true;
      "security.OCSP.enabled" = 1;
      "security.OCSP.require" = true;
      "security.family_safety.mode" = 0;
      "security.cert_pinning.enforcement_level" = 2;
      "security.remote_settings.crlite_filters.enabled" = true;
      "security.pki.crlite_mode" = 2;
      "dom.security.https_only_mode" = true;
      "dom.security.https_only_mode_send_http_background_request" = false;
      "security.ssl.treat_unsafe_negotiation_as_broken" = true;
      "browser.xul.error_pages.expert_bad_cert" = true;

      # Containers
      "privacy.userContext.enabled" = true;
      "privacy.userContext.ui.enabled" = true;

      # Media
      "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
      "media.peerconnection.ice.default_address_only" = true;

      # DOM
      "dom.disable_window_move_resize" = true;

      # Misc
      "accessibility.force_disabled" = 1;
      "browser.helperApps.deleteTempFileOnExit" = true;
      "browser.uitour.enabled" = false;
      "devtools.debugger.remote-enabled" = false;
      "permissions.manager.defaultsUrl" = "";
      "webchannel.allowObject.urlWhitelist" = "";
      "network.IDN_show_punycode" = true;
      "pdfjs.disabled" = true;
      "pdfjs.enableScripting" = false;
      "permissions.delete.enabled" = false;
      "browser.tabs.searchclipboardfor.middleclick" = true;
      "browser.startup.homepage_override.mstone" = "ignore";
      "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
      "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
      "browser.messaging-system.whatsNewPanel.enabled" = false;

      # Downloads
      "browser.download.alwaysOpenPanel" = false;
      "browser.download.manager.addToRecentDocs" = false;
      "browser.download.always_ask_before_handling_new_types" = true;

      # Fingerprinting
      "privacy.resistFingerprinting" = true;
      "browser.link.open_newwindow" = 3;
      "browser.link.open_newwindow.restriction" = 0;

      # Don't touch these
      "extensions.blocklist.enabled" = true;
      "network.http.referer.spoofSource" = false;
      "privacy.firstparty.isolate" = false;
      "extensions.webcompat.enable_shims" = true;
      "security.tls.version.enable-deprecated" = false;
      "extensions.webcompat-reporter.enabled" = false;
      "extensions.quarantinedDomains.enabled" = true;

      # Enable userChrome.css
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    };

    search = {
      force = true;
      default = "DuckDuckGo";
      engines = {
        "Amazon.de" = {
          urls = [{ template = "https://www.amazon.de/s?k={searchTerms}"; }];
          definedAliases = [ ":az" ];
        };

        "Arch Wiki" = {
          urls = [{ template = "https://wiki.archlinux.org/index.php?search={searchTerms}"; }];
          definedAliases = [ ":aw" ];
        };

        "DuckDuckGo" = {
          urls = [{ template = "https://duckduckgo.com/?q={searchTerms}"; }];
          definedAliases = [ ":d" ];
        };

        "Home Manager" = {
          urls = [{ template = "https://mipmip.github.io/home-manager-option-search/?query={searchTerms}"; }];
          definedAliases = [ ":hm" ];
        };

        "Nix Options" = {
          urls = [{
            template = "https://search.nixos.org/options";
            params = [
              { name = "channel"; value = "unstable"; }
              { name = "query"; value = "{searchTerms}"; }
            ];
          }];
          definedAliases = [ ":no" ];
        };

        "Nix Packages" = {
          urls = [{
            template = "https://search.nixos.org/packages";
            params = [
              { name = "channel"; value = "unstable"; }
              { name = "query"; value = "{searchTerms}"; }
            ];
          }];
          definedAliases = [ ":np" ];
        };

        "NixOS Wiki" = {
          urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
          definedAliases = [ ":nw" ];
        };

        "Wikipedia" = {
          urls = [{ template = "https://en.wikipedia.org/wiki/Special:Search?search={searchTerms}"; }];
          definedAliases = [ ":w" ];
        };

        "Wikipedia (de)" = {
          urls = [{ template = "https://de.wikipedia.org/wiki/Special:Search?search={searchTerms}"; }];
          definedAliases = [ ":wd" ];
        };

        "Wikipedia (fi)" = {
          urls = [{ template = "https://fi.wikipedia.org/wiki/Special:Search?search={searchTerms}"; }];
          definedAliases = [ ":wf" ];
        };

        "YouTube" = {
          urls = [{ template = "https://www.youtube.com/results?search_query={searchTerms}"; }];
          definedAliases = [ ":yt" ];
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
}
