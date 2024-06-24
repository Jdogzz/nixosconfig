{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../hardware-configuration/hardware-configuration-lenovolaptop.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-28475a60-654f-4976-8c43-37c30e2472f8".device = "/dev/disk/by-uuid/28475a60-654f-4976-8c43-37c30e2472f8";
  networking.hostName = "lenovolaptop"; # Define your hostname.
}
