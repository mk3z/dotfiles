{...}: {
  imports = [
    ./core.nix
    ./common
    ./gui
    ./hardware
    ./programs
    ./services

    # TODO organize these better
    ./adb.nix
    ./docker.nix
    ./kubernetes.nix
    ./libvirt.nix
    ./mullvad.nix
    ./podman.nix
    ./ratbag.nix
  ];
}
