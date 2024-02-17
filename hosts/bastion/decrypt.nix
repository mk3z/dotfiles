{
  boot.initrd = {
    boot.initrd.kernelModules = ["virtio-pci"];

    luks.forceLuksSupportInInitrd = true;

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
        hostKeys = ["/persist/initrd_ssh_host_ed25519_key"];

        authorizedKeys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKVXV+51+7Evucq9Qi9QCs2LugQii6AjvDfIg3u7oiOe"];
      };
    };
  };
}
