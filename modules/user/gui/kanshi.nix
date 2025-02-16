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
            status = "disable";
          }
          {
            criteria = "LG Electronics LG TV SSCR2 0x01010101";
            status = "enable";
            mode = "3840x2160@60.000";
            position = "0,0";
            scale = 2.0;
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
        fr8.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            mode = "2560x1440@165";
            position = "650,1200";
            scale = 1.6;
            adaptiveSync = true;
          }
          {
            criteria = "PNP(AOC) CU34G2XP 1Q1QAHA000303";
            status = "enable";
            mode = "3440x1440@100.000";
            position = "0,0";
            scale = 1.2;
            adaptiveSync = true;
          }
        ];
      }
      else if hostname == "framework"
      then {
        undocked.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            mode = "2880x1920@120";
            position = "0,0";
            scale = 2.0;
            adaptiveSync = true;
          }
        ];
        home.outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "LG Electronics LG TV SSCR2 0x01010101";
            status = "enable";
            mode = "3840x2160@60.000";
            position = "0,0";
            scale = 2.0;
            adaptiveSync = true;
          }
        ];
        office.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            mode = "2880x1920@120";
            position = "0,0";
            scale = 2.0;
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
        fr8.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            mode = "2880x1920@120";
            position = "0,0";
            scale = 2.0;
            adaptiveSync = true;
          }
          {
            criteria = "PNP(AOC) CU34G2XP 1Q1QAHA000303";
            status = "enable";
            mode = "3440x1440@100.000";
            position = "0,0";
            scale = 1.2;
            adaptiveSync = true;
          }
        ];
      }
      else {};
  };
}
