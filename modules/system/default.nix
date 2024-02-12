{...}: {
  imports = [
    # TODO organize this mess better
    ./core.nix
    ./common
    ./hardware
    ./programs
    ./services

    # features
    ./adb.nix
    ./docker.nix
    ./greetd.nix
    ./kubernetes.nix
    ./libvirt.nix
    ./mullvad.nix
    ./podman.nix
    ./ratbag.nix
  ];
}
