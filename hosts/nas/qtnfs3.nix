{config, ...}: {
  age.secrets.qt-password.file = ../../secrets/qt-password.age;

  services.samba = {
    enable = true;
    securityType = "user";
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "QTNFS3";
        "security" = "user";
      };
      "qt" = {
        "path" = "/media/qt";
        "browsable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "qt";
        "force group" = "qt";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  users.users.qt = {
    group = "qt";
    isNormalUser = true;
    hashedPasswordFile = config.age.secrets.qt-password.path;
    createHome = false;
  };
  users.groups.qt = {};
}
