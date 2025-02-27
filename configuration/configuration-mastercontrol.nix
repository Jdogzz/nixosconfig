{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ../hardware-configuration/hardware-configuration-mastercontrol.nix
    ./modules/paperless.nix
  ];

  boot.initrd.luks.devices."luks-14503795-627e-4b4e-b2a9-d6f427ccdb72".device =
    "/dev/disk/by-uuid/14503795-627e-4b4e-b2a9-d6f427ccdb72";
  networking.hostName = "mastercontrol"; # Define your hostname.

  hardware.bluetooth.enable = true; # enables support for Bluetooth

  services.smartd = {
    enable = true;
    devices = [
      {
        device = "/dev/nvme0";
        options = "-d nvme";
      }
      {
        device = "/dev/nvme1";
        options = "-d nvme";
      }
    ];
  };
}
