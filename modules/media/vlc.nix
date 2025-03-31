{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.java = {
    enable = true;
    package = pkgs.jdk17;
  };

  #This overlay is needed because of the extra compile options for blurays. See https://github.com/NixOS/nixpkgs/issues/63641
  nixpkgs.overlays = [
    (self: super: {
      vlc = super.vlc.override {
        libbluray = super.libbluray.override {
          withAACS = true;
          withBDplus = true;
          withJava = true;
        };
      };
    })
  ];

  environment.systemPackages = with pkgs; [
    vlc
  ];
}
