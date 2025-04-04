{
  config,
  lib,
  pkgs,
  ...
}:

{
  # make the tailscale command usable to users
  environment.systemPackages = [ pkgs.tailscale ];

  # enable the tailscale service
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "both";
}
