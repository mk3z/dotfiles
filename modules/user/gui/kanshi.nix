{osConfig, ...}: let
  inherit (osConfig.mkez.core) hostname;
in {
  services.kanshi = {
    enable = true;
    systemdTarget = "graphical-session.target";
    profiles =
      if hostname == "desktop"
      then {
        default.outputs = [
          {
            # Left
            criteria = "Dell Inc. DELL P2210 7PGVR242AGTL";
            status = "enable";
            mode = "1680x1050@59.88300";
            position = "0,0";
            scale = 1.0;
            transform = "90";
          }
          {
            # Center
            criteria = "Lenovo Group Limited LEN T34w-20 V3077RCP";
            status = "enable";
            mode = "3440x1440@59.97300";
            position = "1050,164";
            scale = 1.33;
          }
          {
            # Right
            criteria = "AOC 27G2G4 GYGLCHA284922";
            status = "enable";
            mode = "1920x1080@74.97300";
            position = "3640,0";
            scale = 1.0;
          }
          # {
          #   # TV
          #   criteria = "LG Electronics LG TV SSCR2 0x01010101";
          #   status = "disable";
          # }
        ];
      }
      else if hostname == "slimbook"
      then {
        undocked.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            mode = "2560x1440@165";
            position = "0,0";
            scale = 1.6;
          }
        ];
        docked.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            mode = "2560x1440@165";
            position = "1580,1080";
            scale = 1.6;
          }
          {
            # Left
            criteria = "Dell Inc. DELL P2210 7PGVR242AGTL";
            status = "enable";
            mode = "1680x1050@59.88300";
            position = "0,0";
            scale = 1.0;
            transform = "90";
          }
          {
            # Center
            criteria = "Lenovo Group Limited LEN T34w-20 V3077RCP";
            status = "enable";
            mode = "3440x1440@59.97300";
            position = "1050,0";
            scale = 1.33;
          }
          {
            # Right
            criteria = "AOC 27G2G4 GYGLCHA284922";
            status = "enable";
            mode = "1920x1080@74.97300";
            position = "3640,0";
            scale = 1.0;
          }
        ];
      }
      else {};
  };
}
