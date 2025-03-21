{
  config,
  lib,
  pkgs,
  ...
}:

{
  users.users.flakeuser = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEpS99mQv9a9BQE59CGlKE0xcZnIp6qalqTXVSvV34fN"
    ];
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };
}
