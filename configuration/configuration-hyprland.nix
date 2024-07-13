{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    #Audio
    helvum # 2024-06-29 I added this to use by waybar for volume control module.
    pavucontrol

    #Lock
    swaylock
  ];

  programs.gnome-disks.enable = true;

  programs.hyprland.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
          ${pkgs.greetd.tuigreet}/bin/tuigreet \
          --time \
          --asterisks \
          --cmd Hyprland''; # This may be necessary to get the xdg mimeapps to be set properly.
      };
    };
  };

  environment.etc."greetd/environments".text = ''
    Hyprland
  '';

  #Needed to prevent Nextcloud from logging out after every session in hyprland.
  #security.pam.services.greetd.enableGnomeKeyring = true;

  #locking the computer
  #programs.sway.enable = true;
  security.pam.services.swaylock = { };
  #security.pam.services.hyprlock = { };
  services.gvfs.enable = true;

}
