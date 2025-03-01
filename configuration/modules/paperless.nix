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
      PAPERLESS_OCR_USER_ARGS = {
        optimize = 1;
        pdfa_image_compression = "lossless";
      };
      PAPERLESS_TIKA_ENABLED = true;
      PAPERLESS_GOTENBERG_ENABLED = true;
    };
    exporter.enable = true;
    dataDir = "/home/flakeuser/generalsync/reference/paperless";
    user = "flakeuser";
  };

  services.gotenberg = {
    enable = true;
  };

  services.tika = {
    enable = true;
    enableOcr = true;
  };

}
