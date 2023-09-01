{ sysPersistDir, ... }:

{
  services.mullvad-vpn.enable = true;

  environment.persistence."${sysPersistDir}".directories = [
    "/etc/mullvad-vpn"
  ];

}
