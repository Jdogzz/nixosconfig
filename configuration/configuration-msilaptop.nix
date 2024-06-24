{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ../hardware-configuration/hardware-configuration-msilaptop.nix
  ];

  boot.initrd.luks.devices."luks-9a7b6837-3bdc-4bb0-a19f-8002c602190a".device = "/dev/disk/by-uuid/9a7b6837-3bdc-4bb0-a19f-8002c602190a";
  networking.hostName = "msilaptop"; # Define your hostname.
}
