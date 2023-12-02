{
  imports = [./icons.nix];

  programs.starship = {
    enable = true;
    settings = {
      right_format = "$cmd_duration $time";

      character = {
        success_symbol = "[λ](green)";
        error_symbol = "[λ](red)";
        vimcmd_symbol = "[λ](blue)";
        vimcmd_replace_one_symbol = "[λ](purple)";
        vimcmd_replace_symbol = "[λ](purple)";
        vimcmd_visual_symbol = "[λ](yellow)";
      };

      cmd_duration = {
        show_milliseconds = true;
        format = "[$duration]($style) ";
        style = "bright-black";
      };

      directory = {
        style = "bold blue";
        truncation_symbol = ".../";
      };

      hostname = {disabled = true;};

      time = {
        format = "[$time]($style) ";
        style = "bright-black";
        disabled = false;
      };

      username.disabled = true;
    };
  };
}
