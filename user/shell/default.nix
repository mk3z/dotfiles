{ inputs, pkgs, homePersistDir, homeDirectory, ... }:

{
  imports = [
    ./tools.nix
    (import ./ssh.nix { inherit homePersistDir homeDirectory; })
    ./starship.nix
  ];

  home.persistence."${homePersistDir}${homeDirectory}" = {
    files = [ ".bash_history" ".local/share/fish/fish_history" ];
  };

  home.packages = with pkgs; [ fishPlugins.fzf-fish fishPlugins.pisces ];

  programs.fish = {
    enable = true;
    shellAbbrs = import ./abbreviations.nix;

    plugins = [{
      name = "fish-ssh-agent";
      src = inputs.fish-ssh-agent;
    }];

    shellInit = ''
      # Disable greeting
      set -U fish_greeting

      # Enable vi mode
      fish_vi_key_bindings
      set fish_cursor_default block
      set fish_cursor_insert line
      set fish_cursor_replace_one underscore
      set fish_cursor_visual block

      # Modify fzf.fish bindings
      fzf_configure_bindings --directory=\\cf --git_log=\\cg --git_status=\\cs --processes=\\cp
    '';
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
