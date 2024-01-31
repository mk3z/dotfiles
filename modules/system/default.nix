{...}: {
  imports = [
    # TODO organize this mess better
    ./common
    ./core.nix
    ./hardware

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
    ./kubernetes.nix
    ./libvirt.nix
    ./monero.nix
    ./mullvad.nix
    ./podman.nix
    ./ratbag.nix
    ./steam.nix
    ./syncthing.nix
  ];
}
