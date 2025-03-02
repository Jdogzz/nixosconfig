{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.partition-manager.enable = true;
  #services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  # services.xserver.displayManager.lightdm = {
  #   enable = true;
  #   greeters.gtk.enable = true;
  # };
  services.desktopManager.plasma6.enable = true;
}
