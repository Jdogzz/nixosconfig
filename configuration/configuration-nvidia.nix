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
      #intel-media-driver
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      nvidia-vaapi-driver
      #intel-media-driver
    ];
    enable32Bit = true;
    package = config.hardware.nvidia.package;
  };

  hardware.nvidia = {
    nvidiaSettings = true;
    powerManagement = {
      enable = true;
    };
    #package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  boot.kernelParams = [
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    "nvidia_drm.fbdev=1"
  ];

  environment.systemPackages = with pkgs; [
    cudatoolkit
    nvtopPackages.nvidia
  ];
}
