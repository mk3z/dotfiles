let
  desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAyDZDc620uBfzn7J0WdlfTodFBib4aCsg1bo7GdOJrv";
  framework = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBDBntTB+Xhui/IciIGZW78dwlKxljidVH+q8FRDQQYA";
  nas = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOZJWC/8EUEHQBw+g+XAoJuMC//URljkv5Nt+OegL8mW";
  bastion = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEpiHcS0lUe5tPkQz5JuVs6wPk8L/g+fdQR3aOPYpoez";

  workstations = [desktop framework];
  servers = [nas];
in {
  "password.age".publicKeys = workstations ++ servers;

  "borg.age".publicKeys = workstations;

  "bastion-password.age".publicKeys = [bastion];
  "email-password.age".publicKeys = [bastion];

  "htpasswd.age".publicKeys = [nas];
  "cloudflare.env.age".publicKeys = [nas];
  "vaultwarden.env.age".publicKeys = [nas];
  "firefox-sync-secrets.age".publicKeys = [nas];

  "vpn-wg-conf.age".publicKeys = [nas];
}
