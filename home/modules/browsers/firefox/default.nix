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

      FirefoxHome = {
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
        single-file
        ublacklist
        ublock-origin
        zotero-connector
      ];
      settings = {
        "browser.aboutConfig.showWarning" = false;
        "browser.disableResetPrompt" = true;
        "browser.download.defaultFolder" = "/home/flakeuser/generalsync/inbox";
        "browser.download.dir" = "/home/flakeuser/generalsync/inbox";
        "browser.download.folderList" = 2;
        "browser.download.panel.shown" = true;
        "browser.download.useDownloadDir" = false;
        "browser.ml.chat.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.system.topstories" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.pinned" = "";
        #"browser.startup.page" = 3;
        "browser.tabs.firefox-view" = false;
        "browser.toolbars.bookmarks.visibility" = "never";
        "dom.security.https_only_mode" = true;
        "extensions.autoDisableScopes" = 0; # 2025-03-15 Added to prevent extensions from being automatically disabled.
        "identity.fxaccounts.enabled" = false;
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

  imports = [
    ./privacy.nix
  ];
}
