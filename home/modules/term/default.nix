{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    #Terminal colorization
    dotacat
    grc

    #Terminal formatting
    figlet
  ];

  programs.dircolors = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.direnv = {
    enable = true;
  };

  programs.foot = {
    enable = true;
  };

  programs.starship = {
    enable = true;
  };

  imports = [
    ./fish.nix
  ];
}
