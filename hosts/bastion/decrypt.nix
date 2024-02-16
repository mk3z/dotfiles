{lib, ...}: {
  boot.initrd = {
    # Network card drivers. Check `lshw` if unsure.
    kernelModules = ["smsc95xx" "usbnet"];
    # It may be necessary to wait a bit for devices to be initialized.
    # See https://github.com/NixOS/nixpkgs/issues/98741
    preLVMCommands = lib.mkBefore 400 "sleep 1";
    # Your post-boot network configuration is taken
    # into account. It should contain:
    networking.useDHCP = false;
    networking.interfaces.enp1s0.useDHCP = true;

    luks.forceLuksSupportInInitrd = true;
    # If necessary, kernel modules required to access
    # the root device. For example, on a Raspberry Pi
    # 3B+, with the root disk attached via USB, this is:
    availableKernelModules = ["usb_storage"];

    network = {
      enable = true;
      ssh = {
        enable = true;
        # Defaults to 22.
        port = 222;
        # Stored in plain text on boot partition, so don't reuse your host
        # keys. Also, make sure to use a boot loader with support for initrd
        # secrets (e.g. systemd-boot), or this will be exposed in the nix store
        # to unprivileged users.
        hostKeys = ["/boot/initrd_ssh_host_ed25519_key"];
        # I'll just authorize all keys authorized post-boot.
        authorizedKeys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKVXV+51+7Evucq9Qi9QCs2LugQii6AjvDfIg3u7oiOe"];
      };
      # Set the shell profile to meet SSH connections with a decryption
      # prompt that writes to /tmp/keyfile if successful.
      network.postCommands = let
        # I use a LUKS 2 label. Replace this with your disk device's path.
        disk = "/dev/disk/by-label/crypt";
      in ''
        echo 'cryptsetup open ${disk} crypt --type luks && echo > /tmp/keyfile' >> /root/.profile
        echo 'starting sshd...'
      '';
      # Block the boot process until /tmp/continue is written to
      postDeviceCommands = ''
        echo 'waiting for root device to be opened...'
        mkfifo /tmp/continue
        cat /tmp/continue
      '';
    };
  };
}