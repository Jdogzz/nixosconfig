{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    #Audio
    helvum # 2024-06-29 I added this to use by waybar for volume control module.
    pavucontrol
    qpwgraph # 2025-02-03 I added this to reroute audio from Firefox when using hyprland.

    #Lock
    # swaylock
  ];

  programs.gnome-disks.enable = true;

  # services.displayManager.sddm.enable = true;
  # services.displayManager.sddm.wayland.enable = true;

  programs.hyprland = {
    enable = true;
    #package = inputs.hyprland.packages.x86_64-linux.hyprland;
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
  #programs.sway.enable = true;
  # security.pam.services.swaylock = { };
  security.pam.services.hyprlock = { };

  #2025-02-03 May have been added to allow mounting in Dolphin
  services.gvfs.enable = true;
}
