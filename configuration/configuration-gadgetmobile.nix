# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../hardware-configuration/hardware-configuration-gadgetmobile.nix
    ];

  boot.initrd.luks.devices."luks-d9b3a388-0cdd-4432-9d94-5705a799d4a0".device = "/dev/disk/by-uuid/d9b3a388-0cdd-4432-9d94-5705a799d4a0";
  networking.hostName = "gadgetmobile"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
}
