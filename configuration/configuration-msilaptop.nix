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
    ./configuration.nix
  ];

  boot.initrd.luks.devices."luks-719c339a-6a5e-479d-a9d5-cfebe3e29854".device =
    "/dev/disk/by-uuid/719c339a-6a5e-479d-a9d5-cfebe3e29854";
  networking.hostName = "msilaptop"; # Define your hostname.
}
