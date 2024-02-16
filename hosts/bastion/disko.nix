{
  disko = {
    enableConfig = true;
    devices.disk.sda = {
      type = "disk";
      device = "/dev/sda";

      content = {
        type = "gpt";
        partitions = {
          ESP = {
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "boot";
              mountOptions = ["defaults"];
            };
          };

          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "crypt";
              extraOpenArgs = [];
              settings = {
                keyFile = "/tmp/keyfile";
                allowDiscards = true;
              };
              content = {
                type = "lvm_pv";
                vg = "pool";
              };
            };
          };
        };
      };
    };

    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = ["defaults" "size=4G" "nr_inodes=0" "mode=755"];
    };

    lvm_vg = {
      pool = {
        type = "lvm_vg";
        lvs = {
          nix = {
            size = "20G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/nix";
              mountOptions = [
                "defaults"
              ];
            };
          };

          swap = {
            size = "8G";
            content.type = "swap";
          };

          persist = {
            size = "100%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/persist";
            };
          };
        };
      };
    };
  };
}
