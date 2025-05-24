{
  config,
  lib,
  pkgs,
  ...
}:

{
  networking.firewall.allowedTCPPorts = [
    28981 # Paperless-ngx default port
  ];

  services.paperless = {
    enable = true;
    address = "0.0.0.0";
    settings = {
      PAPERLESS_OCR_OUTPUT_TYPE = "pdf"; # 2025-02-28 Adding this in to preserve hyperlinks in PDFs generated
      PAPERLESS_OCR_LANGUAGE = "eng";
    };
    exporter.enable = true;
    dataDir = "/home/flakeuser/servicesync/paperless";
    user = "flakeuser";
    configureTika = true;
  };

}
