{
  config,
  lib,
  pkgs,
  ...
}:

{
  xdg.desktopEntries = {
    bwvm = {
      name = "bwvm";
      genericName = "Virtual machine";
      exec = "quickemu --vm windows-11.conf --display spice --public-dir ~/generalsync/inbox/Public/";
      settings = {
        Path = "/mnt/seconddrive/vmsync/bwvm/";
      };
    };
    gwvm = {
      name = "gwvm";
      genericName = "Virtual machine";
      exec = "quickemu --vm windows-11.conf --display spice --public-dir ~/generalsync/inbox/Public/";
      settings = {
        Path = "/mnt/seconddrive/vmsync/generalservicesvm/";
      };
    };
    fbvm = {
      name = "fbvm";
      genericName = "Virtual machine";
      exec = "quickemu --vm windows-11.conf --display spice --public-dir ~/generalsync/inbox/Public/";
      settings = {
        Path = "/mnt/seconddrive/vmsync/fabvm/";
      };
    };
  };
}
