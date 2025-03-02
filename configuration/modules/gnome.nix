{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.xserver.enable = true;
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.displayManager.gdm.wayland = false;
  services.xserver.displayManager.lightdm = {
    enable = true;
    greeters.gtk.enable = true;
  };
  services.xserver.desktopManager.gnome.enable = true;
}
