{
  config,
  lib,
  pkgs,
  ...
}:

{
  stylix = {
    enable = true;
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/monokai.yaml";
    fonts.monospace.package = pkgs.nerd-fonts.jetbrains-mono;
    image = ./wallpaper.jpg;
    opacity = {
      applications = 0.8;
      desktop = 0.8;
      terminal = 0.8;
    };
    polarity = "dark";
    targets = {
      hyprlock = {
        useWallpaper = true;
      };
    };
  };
}
