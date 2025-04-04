{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./audio.nix
    ./browsers
    ./desktop.nix
    ./emacs
    ./email.nix
    ./fonts.nix
    ./hyprland.nix
    ./media
    ./term
    ./waybar.nix
  ];
}
