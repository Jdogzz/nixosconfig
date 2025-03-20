{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
  };

  #Added to speed up direnv usage with nix https://github.com/doomemacs/doomemacs/tree/master/modules/tools/direnv#direnv--nix-is-slow
  services.lorri.enable = true;
}
