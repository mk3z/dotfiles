{config, ...}: {
  age.secrets.vpn-wg-conf.file = ../../secrets/vpn-wg-conf.age;
  # TODO: start after tailscale
  networking.wg-quick.interfaces.vpn.configFile = config.age.secrets.vpn-wg-conf.path;
}
