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

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-3a0f50ad-04eb-4174-8c78-3fbf4e3a2bef".device = "/dev/disk/by-uuid/3a0f50ad-04eb-4174-8c78-3fbf4e3a2bef";
  boot.initrd.luks.devices."luks-3a0f50ad-04eb-4174-8c78-3fbf4e3a2bef".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "mastercontrol"; # Define your hostname.
}
