{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    poppler-utils # Needed for dirvish pdf display and pdf-tools
    vips # Needed for dirvish image display
  ];
}
