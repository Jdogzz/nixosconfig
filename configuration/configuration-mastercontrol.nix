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
  ];

  boot.initrd.luks.devices."luks-14503795-627e-4b4e-b2a9-d6f427ccdb72".device =
    "/dev/disk/by-uuid/14503795-627e-4b4e-b2a9-d6f427ccdb72";
  networking.hostName = "mastercontrol"; # Define your hostname.

  services.smartd = {
    enable = true;
    devices = [
      {
        device = "/dev/disk/by-uuid/6294b1bd-3d1f-412f-b231-3b34a37a6ba6";
      }
      {
        device = "/dev/disk/by-uuid/7a74dfcf-b30e-4dae-9cac-72a1f28b0556";
      }
    ];
  };
}
