{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.firefox = {
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
    };

    profiles.flakeuser = {
      settings = {
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.search.serpEventTelemetryCategorization.enabled" = false;
        "datareporting.usage.uploadEnabled" = false;
        "identity.fxaccounts.telemetry.clientAssociationPing.enabled" = false;
        "network.trr.confirmation_telemetry_enabled" = false;
        "nimbus.telemetry.targetingContextEnabled" = false;
        "telemetry.fog.init_on_shutdown" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
      };
    };
  };
}
