{ pkgs, ... }:
{
  programs.firefox.profiles.default.extensions = [ pkgs.nur.repos.rycee.firefox-addons.tridactyl ];

  home.file = {
    ".mozilla/native-messaging-hosts/tridactyl.json" = {
      recursive = true;
      text = ''
        {
            "name": "tridactyl",
            "description": "Tridactyl native command handler",
            "path": "${pkgs.tridactyl-native}/bin/native_main",
            "type": "stdio",
            "allowed_extensions": [ "tridactyl.vim@cmcaine.co.uk","tridactyl.vim.betas@cmcaine.co.uk", "tridactyl.vim.betas.nonewtab@cmcaine.co.uk" ]
        }

      '';
    };
    ".config/tridactyl/tridactylrc" = {
      recursive = true;
      source = ./tridactylrc;
    };
  };
}
