# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/system.nix
    ../../modules/paperless.nix
    ../../modules/tailscale-performance-miniserver.nix
    ../../modules/docker.nix
    ../../modules/audiobookshelf.nix
  ];

  boot.initrd.luks.devices."luks-0d836c4a-d4d5-4853-a706-9ae17daa3157".device =
    "/dev/disk/by-uuid/0d836c4a-d4d5-4853-a706-9ae17daa3157";
  networking.hostName = "miniserver"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
}
