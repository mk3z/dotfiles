{...}: {
  imports = [
    ./bluetooth.nix
    ./bolt.nix
    ./fprint.nix
    ./laptop.nix
    ./rtl-sdr.nix
    ./sound.nix
    ./yubikey.nix
    ./zfs.nix
    ./zsa.nix
  ];
}
