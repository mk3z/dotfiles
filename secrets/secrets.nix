let
  desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAyDZDc620uBfzn7J0WdlfTodFBib4aCsg1bo7GdOJrv";
  slimbook = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBDBntTB+Xhui/IciIGZW78dwlKxljidVH+q8FRDQQYA";
  workstations = [desktop slimbook];
in {
  "password.age".publicKeys = workstations;
  "borg.age".publicKeys = workstations;
}
