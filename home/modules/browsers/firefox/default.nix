{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  programs.firefox = {
    enable = true;
    policies = {
      DontCheckDefaultBrowser = true;
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableFirefoxScreenshots = true;

      DisplayBookmarksToolbar = "never";

      HardwareAcceleration = true;
      TranslateEnabled = true;

      Homepage.StartPage = "previous-session";

      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
      };

      EnableTrackingProtection = {
        Value = true;
        Cryptomining = true;
        Fingerprinting = true;
      };

      FirefoxHome = # Make new tab only show search
        {
          Search = true;
          TopSites = true;
          SponsoredTopSites = false;
          Highlights = false;
          Pocket = false;
          SponsoredPocket = false;
          Snippets = false;
        };
    };
    profiles.flakeuser = {
      bookmarks = { };
      extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [
        darkreader
        greasemonkey
        hls-stream-detector
        keepassxc-browser
        #sidebery #2025-03-16 Trying out the built in vertical tabs feature.
        ublacklist
        ublock-origin
        zotero-connector
      ];
      settings = {
        "browser.aboutConfig.showWarning" = false;
        "browser.disableResetPrompt" = true;
        "browser.download.dir" = "/home/flakeuser/generalsync/inbox";
        "browser.download.panel.shown" = true;
        "browser.download.useDownloadDir" = false;
        "browser.ml.chat.enabled" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.pinned" = "";
        # "browser.search.defaultenginename" = "DuckDuckGo";
        # "browser.search.order.1" = "DuckDuckGo";
        #"browser.shell.checkDefaultBrowser" = false;
        #"browser.shell.defaultBrowserCheckCount" = 1;
        #"browser.startup.page" = 3;
        "browser.tabs.firefox-view" = false;
        "browser.toolbars.bookmarks.visibility" = "never";
        "dom.security.https_only_mode" = true;
        "extensions.autoDisableScopes" = 0; # 2025-03-15 Added to prevent extensions from being automatically disabled.
        #"extensions.pocket.enabled" = false;
        "identity.fxaccounts.enabled" = false;
        #"privacy.trackingprotection.enabled" = true;
        "sidebar.verticalTabs" = true;
        "signon.rememberSignons" = false;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
      search = {
        force = true;
        default = "ddg";
        order = [
          "ddg"
        ];
      };
      userChrome = builtins.readFile ./userChrome.css;
      userContent = builtins.readFile ./userContent.css;
    };
  };

  stylix.targets.firefox.profileNames = [ "flakeuser" ];
}
