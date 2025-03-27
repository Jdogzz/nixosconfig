{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  programs.gnome-disks.enable = true;

  programs.hyprland = {
    enable = true;
  };

  services.greetd = {
    enable = true;
    settings = rec {
      # default_session = {
      #   command = ''
      #     ${pkgs.greetd.tuigreet}/bin/tuigreet \
      #     --time \
      #     --asterisks \
      #     --cmd Hyprland''; # This may be necessary to get the xdg mimeapps to be set properly.
      # };
      initial_session = {
        command = "Hyprland";
        user = "flakeuser";
      };
      default_session = initial_session;
    };
  };

  # environment.etc."greetd/environments".text = ''
  #   Hyprland
  # '';

  #Needed to prevent Nextcloud from logging out after every session in hyprland.
  #security.pam.services.greetd.enableGnomeKeyring = true;

  #locking the computer
  security.pam.services.hyprlock = { };

  #2025-02-03 May have been added to allow mounting in Dolphin
  services.gvfs.enable = true;
}
