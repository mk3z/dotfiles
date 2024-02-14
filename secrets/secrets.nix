let
  desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAyDZDc620uBfzn7J0WdlfTodFBib4aCsg1bo7GdOJrv";
  slimbook = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBDBntTB+Xhui/IciIGZW78dwlKxljidVH+q8FRDQQYA";
  memory-alpha = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOZJWC/8EUEHQBw+g+XAoJuMC//URljkv5Nt+OegL8mW";

  workstations = [desktop slimbook];
  servers = [memory-alpha];
in {
  "password.age".publicKeys = workstations ++ servers;
  "borg.age".publicKeys = workstations;
}
