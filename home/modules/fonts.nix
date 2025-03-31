{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    corefonts # Cautiously reenabling, the download for this is brittle
    eb-garamond
    font-awesome
    garamond-libre
    iosevka
    liberation_ttf
    libre-caslon
    lmodern
    material-design-icons
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    noto-fonts-extra
    powerline-fonts
    source-code-pro
    vistafonts
  ];

  fonts.fontconfig.enable = true;
}
