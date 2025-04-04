{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    libtool # Adding for vterm compilation
  ];

  programs.emacs.extraPackages = epkgs: [
    epkgs.vterm
  ];
}
