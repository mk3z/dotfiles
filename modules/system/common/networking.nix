{
  networking = {
    firewall.enable = true;
    networkmanager = {
      enable = true;
      dns = "none";
      wifi.macAddress = "random";
      ethernet.macAddress = "random";
    };
  };
}
