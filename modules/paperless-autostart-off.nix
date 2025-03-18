{
  config,
  lib,
  pkgs,
  ...
}:

{
  systemd.services.paperless-scheduler.wantedBy = lib.mkForce [ ];
  systemd.services.redis-paperless.wantedBy = lib.mkForce [ ];
  systemd.services.gotenberg.wantedBy = lib.mkForce [ ];
  systemd.services.tika.wantedBy = lib.mkForce [ ];

}
