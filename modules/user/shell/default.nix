{
  osConfig,
  inputs,
  pkgs,
  ...
}: let
  inherit (osConfig.mkez.core) homePersistDir;
  inherit (osConfig.mkez.user) homeDirectory;
in {
  imports = [
    ./abbreviations
    ./tools.nix
    ./ssh.nix
    ./starship.nix
  ];

  home.persistence."${homePersistDir}${homeDirectory}" = {
    files = [".bash_history" ".local/share/fish/fish_history"];
    directories = [".local/share/direnv"];
  };

  home.packages = with pkgs; [fishPlugins.fzf-fish fishPlugins.grc fishPlugins.pisces grc];

  programs.fish = {
    enable = true;

    plugins = [
      {
        name = "fish-ssh-agent";
        src = inputs.fish-ssh-agent;
      }
      {
        name = "fish-git-abbr";
        src = inputs.fish-git;
      }
      {
        name = "kubectl-fish-abbr";
        src = inputs.fish-kubectl;
      }
    ];

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
