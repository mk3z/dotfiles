{...}: {
  imports = [./plugins.nix];
  programs.nixvim = {
    enable = true;
    enableMan = false;

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
}
