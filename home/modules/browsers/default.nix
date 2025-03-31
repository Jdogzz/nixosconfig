{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    ungoogled-chromium
  ];

  imports = [
    ./firefox
  ];
}
