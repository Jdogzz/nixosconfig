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
    privateKeyFile = "/home/flakeuser/.radicle/keys/radicle";
    publicKey = "/home/flakeuser/.radicle/keys/radicle.pub";
  };
}
