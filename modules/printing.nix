{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    #cups-pdf.enable = true; #2025-03-13 No longer use this, can remove in the future
    drivers = [
      pkgs.hplipWithPlugin # 2025-03-13 Should be good to remove this soon with HP printer slated for removal
      (pkgs.writeTextDir "share/cups/model/xrx6515.ppd" (builtins.readFile ./printerconfig/xrx6515.ppd)) # Adding config for Xerox 6515 printer
    ];
  };

  # Enable autodiscovery of network printers: https://wiki.nixos.org/wiki/Printing#Enable_autodiscovery_of_network_printers
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    # for a WiFi printer
    openFirewall = true;
  };

}
