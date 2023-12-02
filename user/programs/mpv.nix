{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    defaultProfiles = ["gpu-hq"];
    scripts = with pkgs.mpvScripts; [
      mpris
      quality-menu
      thumbnail
      sponsorblock
    ];
    config = {
      profile = "gpu-hq";
      ytdl-format = "bestvideo+bestaudio";
      osc = "no";
    };
    bindings = {
      F = "script-binding quality_menu/video_formats_toggle";
    };
  };
}
