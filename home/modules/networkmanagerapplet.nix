{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    networkmanagerapplet # 2025-03-14 Seems to be needed for icons to work properly.
  ];

  services.network-manager-applet.enable = true;
}
