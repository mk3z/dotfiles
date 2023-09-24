let
  system =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBDBntTB+Xhui/IciIGZW78dwlKxljidVH+q8FRDQQYA";
in
{
  "password.age".publicKeys = [ system ];
  "borg.age".publicKeys = [ system ];
}
