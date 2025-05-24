{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    ffmpegthumbnailer # Needed for dirvish image thumbnail display
    poppler-utils # Needed for dirvish pdf display and pdf-tools
    vips # Needed for dirvish image display
  ];
}
