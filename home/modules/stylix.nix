{
  config,
  lib,
  pkgs,
  ...
}:

{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/monokai.yaml";
    image = ../../wallpaper.jpg;
  };
}
