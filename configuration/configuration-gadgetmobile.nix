# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../hardware-configuration/hardware-configuration-gadgetmobile.nix
    ];

  boot.initrd.luks.devices."luks-a32ddfdf-3e43-4b1f-b322-37920daf8282".device = "/dev/disk/by-uuid/a32ddfdf-3e43-4b1f-b322-37920daf8282";
  networking.hostName = "gadgetmobile"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
}
