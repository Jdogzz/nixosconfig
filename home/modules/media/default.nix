{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    jellyfin-media-player
    # (kdePackages.k3b.override # Removing transcode dependency while waiting for PR: https://github.com/NixOS/nixpkgs/pull/358364
    #   { transcode = null; }
    # )

    (kodi-wayland.passthru.withPackages (kodiPkgs: with kodiPkgs; [ jellyfin ]))

    #Audio
    kdePackages.k3b
    picard

    #Books
    (calibre.override {
      unrarSupport = true;
    })

    #Images
    darktable
    gimp-with-plugins
    (imagemagick.override { libwebpSupport = true; })

    #Video
    ffmpeg
    makemkv
    mkvtoolnix
    yt-dlp
  ];

  programs.mpv.enable = true;
}
