{
  lib,
  config,
  inputs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mkez.editors.nvim;
in {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./plugins.nix
  ];

  options.mkez.editors.nvim.enable = mkEnableOption "Enable neovim";

  config = mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      enableMan = false;
      luaLoader.enable = true;

      colorschemes.nord.enable = true;

      globals = {
        mapleader = " ";
      };

      clipboard.providers.wl-copy.enable = true;

      options = {
        clipboard = "unnamedplus";

        tabstop = 2;
        shiftwidth = 2;
        expandtab = true;

        number = true;
        signcolumn = "yes";
        cursorline = true;
        guicursor = "a:blinkon0,n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20";
        scrolloff = 8;

        timeoutlen = 200;
      };

      extraConfigVim = ''
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
    };
  };
}
