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
            adaptiveSync = true;
          }
          {
            # Center
            criteria = "Lenovo Group Limited LEN T34w-20 V3077RCP";
            status = "enable";
            mode = "3440x1440@59.97300";
            position = "1050,164";
            scale = 1.33;
            adaptiveSync = true;
          }
          {
            # Right
            criteria = "AOC 27G2G4 GYGLCHA284922";
            status = "enable";
            mode = "1920x1080@74.97300";
            position = "3640,0";
            scale = 1.0;
            adaptiveSync = true;
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
            adaptiveSync = true;
          }
        ];
        home.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            mode = "2560x1440@165";
            position = "1626,1152";
            scale = 1.6;
            adaptiveSync = true;
          }
          {
            # Left
            criteria = "Dell Inc. DELL P2210 7PGVR242AGTL";
            status = "enable";
            mode = "1680x1050@59.88300";
            position = "0,0";
            scale = 1.0;
            transform = "90";
            adaptiveSync = true;
          }
          {
            # Center
            criteria = "Lenovo Group Limited LEN T34w-20 V3077RCP";
            status = "enable";
            mode = "3440x1440@59.97300";
            position = "1050,0";
            scale = 1.25;
            adaptiveSync = true;
          }
          {
            # Right
            criteria = "PNP(AOC) 27G2G4 GYGLCHA284922";
            status = "enable";
            mode = "1920x1080@74.97300";
            position = "3802,72";
            scale = 1.0;
            adaptiveSync = true;
          }
        ];
        office.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            mode = "2560x1440@165";
            position = "277,1200";
            scale = 1.6;
            adaptiveSync = true;
          }
          {
            criteria = "HP Inc. HP E27u G5 CN43440FY6";
            status = "enable";
            mode = "2560x1440@75.001";
            position = "0,0";
            scale = 1.2;
            adaptiveSync = true;
          }
        ];
      }
      else {};
  };
}
