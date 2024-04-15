{config, ...}: {
  age.secrets.vpn-wg-conf.file = ../../secrets/vpn-wg-conf.age;
  networking.wg-quick.interfaces.vpn.configFile = config.age.secrets.vpn-wg-conf.path;
}
