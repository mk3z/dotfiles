{ pkgs, homePersistDir, homeDirectory, ... }:

{
  home.persistence."${homePersistDir}${homeDirectory}".directories =
    [ ".config/VSCodium/Preferences" ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      arcticicestudio.nord-visual-studio-code
      bbenoist.nix
      github.copilot
      kamadorueda.alejandra
      vscodevim.vim
    ];
    userSettings = {
      "editor.inlineSuggest.enabled" = true;
      "security.workspace.trust.untrustedFiles" = "open";
      "window.menuBarVisibility" = "hidden";
      "workbench.startupEditor" = "none";
      "workbench.colorTheme" = "Nord";
    };
  };

  # Tell VS Code to use Wayland
  home.file.".vscode-oss/argv.json" = {
    recursive = true;
    text = ''
      {
        "enable-features": "UseOzonePlatform",
        "ozone-platform" : "wayland",
        "password-store":"gnome"
      }
    '';
  };

  stylix.targets.vscode.enable = false;
}
