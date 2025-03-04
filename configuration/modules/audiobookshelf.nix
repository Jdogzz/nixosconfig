{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.audiobookshelf = {
    enable = true;
    user = "flakeuser";
    openFirewall = true;
    host = "0.0.0.0";
    dataDir = "/home/flakeuser/servicesync/audiobookshelf";
  };
}
