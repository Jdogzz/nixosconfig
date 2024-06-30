{
  config,
  lib,
  pkgs,
  ...
}:

{
  hardware.graphics = {
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      intel-media-driver
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      nvidia-vaapi-driver
      intel-media-driver
    ];
    enable = true;
    enable32Bit = true;
    package = config.hardware.nvidia.package;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  #boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    powerManagement = {
      enable = true;
    };
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];
}
