{
  networking = {
    firewall.enable = true;
    nameservers = ["127.0.0.1"];
    networkmanager = {
      enable = true;
      dns = "none";
      wifi.macAddress = "random";
      ethernet.macAddress = "random";
    };
  };

  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      listen_addresses = ["127.0.0.1:53"];
      bootstrap_resolvers = ["9.9.9.9:53"];

      require_dnssec = true;
      require_nolog = true;
      require_nofilter = true;

      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };
    };
  };

  systemd.services.dnscrypt-proxy2.serviceConfig = {
    StateDirectory = "dnscrypt-proxy";
  };
}
