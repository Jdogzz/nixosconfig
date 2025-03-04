{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = [
    pkgs.audiobookshelf
  ];

  systemd.services.audiobookshelf = {
    description = "Audiobookshelf is a self-hosted audiobook and podcast server";

    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "simple";
      User = "flakeuser";
      Group = "users";
      StateDirectory = "audiobookshelf";
      WorkingDirectory = "/home/flakeuser/servicesync/audiobookshelf";
      ExecStart = "${pkgs.audiobookshelf}/bin/audiobookshelf --host 0.0.0.0 --port 8000";
      Restart = "on-failure";
    };
  };

  networking.firewall.allowedTCPPorts = [ 8000 ];

  #2025-03-04 The nixos provided service requires running in /var/lib so I'm extracting the basics to run it myself.
  # services.audiobookshelf = {
  #   enable = true;
  #   user = "flakeuser";
  #   openFirewall = true;
  #   host = "0.0.0.0";
  #   dataDir = "/home/flakeuser/servicesync/audiobookshelf";
  # };
}
