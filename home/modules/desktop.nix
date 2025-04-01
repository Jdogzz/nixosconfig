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
      path = "/mnt/seconddrive/vmsync/bwvm/";
      exec = "quickemu --vm windows-11.conf --display spice --public-dir ~/generalsync/inbox/Public/";
    };
    gwvm = {
      name = "gwvm";
      genericName = "Virtual machine";
      path = "/mnt/seconddrive/vmsync/generalservicesvm/";
      exec = "quickemu --vm windows-11.conf --display spice --public-dir ~/generalsync/inbox/Public/";
    };
    fbvm = {
      name = "fbvm";
      genericName = "Virtual machine";
      path = "/mnt/seconddrive/vmsync/fabvm/";
      exec = "quickemu --vm windows-11.conf --display spice --public-dir ~/generalsync/inbox/Public/";
    };
  };
}
