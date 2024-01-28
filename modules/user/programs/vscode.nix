{
  pkgs,
  homePersistDir,
  homeDirectory,
  ...
}: {
  home.persistence."${homePersistDir}${homeDirectory}".directories = [".config/VSCodium/Preferences"];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      arcticicestudio.nord-visual-studio-code
      bbenoist.nix
      github.copilot
      kamadorueda.alejandra
      ms-vscode-remote.remote-ssh
      scalameta.metals
      vscodevim.vim
    ];
    userSettings = {
      "editor.inlineSuggest.enabled" = true;
      "editor.fontLigatures" = true;

      "security.workspace.trust.untrustedFiles" = "open";

      "window.menuBarVisibility" = "hidden";
      "window.zoomLevel" = 2;
      "workbench.startupEditor" = "none";
      "workbench.colorTheme" = "Nord";

      "keyboard.dispatch" = "keyCode";

      "vim.leader" = " ";
      "vim.vimrc.enable" = true;
      "vim.useSystemClipboard" = true;

      "files.watcherExclude" = {
        "**/.bloop" = true;
        "**/.metals" = true;
        "**/.ammonite" = true;
      };
    };
  };

  home.file = {
    ".vimrc".text = ''
      noremap e k
      noremap i l
      noremap k n
      noremap l u
      noremap m h
      noremap n j
      noremap u i
      noremap E K
      noremap I L
      noremap K N
      noremap L U
      noremap M H
      noremap N J
      noremap U I
    '';

    # Tell VS Code to use Wayland
    ".vscode-oss/argv.json" = {
      recursive = true;
      text = ''
        {
          "enable-features": "UseOzonePlatform",
          "ozone-platform": "wayland",
          "password-store": "gnome"
        }
      '';
    };
  };

  stylix.targets.vscode.enable = false;
}
