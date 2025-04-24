{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.radicle = {
    enable = true;
    node.openFirewall = true;
  };
}
