{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf (!config.mkez.core.server) {
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
  };
}
