{username, ...}: {
  networking = {
    firewall.enable = true;
    networkmanager = {
      enable = true;
      wifi.macAddress = "random";
      ethernet.macAddress = "random";
    };
  };

  users.users.${username}.extraGroups = ["networkmanager"];
}
