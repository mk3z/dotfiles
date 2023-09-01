{ config, lib, pkgs, ... }:

{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  sound.mediaKeys.enable = true;

  # Enable realtime scheduling for user processes
  security.rtkit.enable = true;
}
