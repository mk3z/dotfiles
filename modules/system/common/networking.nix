{
  networking = {
    firewall.enable = true;
    networkmanager = {
      enable = true;
      wifi.macAddress = "random";
      ethernet.macAddress = "random";
    };
  };
}
