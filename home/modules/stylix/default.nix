{
  config,
  lib,
  pkgs,
  ...
}:

{
  stylix = {
    targets = {
      firefox.profileNames = [ "flakeuser" ];
      hyprlock = {
        useWallpaper = true;
      };
    };
  };
}
