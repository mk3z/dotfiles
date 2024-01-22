{
  pkgs,
  username,
  homePersistDir,
  ...
}: {
  services.monero.enable = true;

  environment = {
    systemPackages = [pkgs.monero-cli];
    persistence.${homePersistDir}.users.${username}.directories = [".xmr"];
  };
}
