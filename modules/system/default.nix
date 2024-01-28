{...}: {
  imports = [
    # TODO organize this mess better
    ./common
    ./core.nix

    # hardware
    ./amd.nix
    ./amdgpu.nix
    ./bluetooth.nix
    ./laptop.nix
    ./zfs.nix

    # common features
    ./sound.nix
    ./fonts.nix
    ./keyring.nix
    ./man.nix
    ./theme.nix

    # features
    ./autoupgrade.nix
    ./borg.nix
    ./docker.nix
    ./greetd.nix
    ./libvirt.nix
    ./monero.nix
    ./mullvad.nix
    ./podman.nix
    ./ratbag.nix
    ./steam.nix
    ./syncthing.nix
  ];
}
