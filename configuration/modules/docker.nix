{
  config,
  lib,
  pkgs,
  ...
}:

{
  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    docker-compose
  ];

  networking.firewall.allowedTCPPorts = [
    8083 # calibre-web-automated
  ];
  networking.firewall.allowedUDPPorts = [
    8083 # calibre-web-automated
  ];

}
