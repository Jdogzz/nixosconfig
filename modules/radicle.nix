{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.radicle = {
    enable = true;
    openFirewall = true;
  };
}
