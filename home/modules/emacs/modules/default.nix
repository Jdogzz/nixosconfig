{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./emacs
    ./term
  ];
}
