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

  hardware.nvidia.prime = {
    sync.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  boot.kernelParams = [
    "module_blacklist=i915"
  ];

  boot.initrd.luks.devices."luks-719c339a-6a5e-479d-a9d5-cfebe3e29854".device = "/dev/disk/by-uuid/719c339a-6a5e-479d-a9d5-cfebe3e29854";
  networking.hostName = "msilaptop"; # Define your hostname.
}
