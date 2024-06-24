let
  flakeuser = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEpS99mQv9a9BQE59CGlKE0xcZnIp6qalqTXVSvV34fN";
in
{
  "secret1.age".publicKeys = [ flakeuser ];
  "secret2.age".publicKeys = [ flakeuser ];
  "secret3.age".publicKeys = [ flakeuser ];
}
