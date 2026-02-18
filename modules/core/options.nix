{
  flake.modules.nvf.options = {
    vim.options = let
      spaces = 4;
    in {
      expandtab = true;
      smarttab = true;
      shiftwidth = spaces;
      tabstop = spaces;
      autoindent = true;

      clipboard = "unnamedplus"; # TODO: check for system clipboard availability
      ignorecase = true;
      smartcase = true;
      wrap = false;
      timeoutlen = 500;

      showmode = false;
      foldmethod = "expr";
      foldlevel = 999; # disable autofolding
      fillchars = "eob: ";
      termguicolors = true;
      number = true;
      relativenumber = true;
      cursorline = true;
      signcolumn = "yes"; # always show signcolumn (e.g. lsp warnings)
      ruler = false;
      laststatus = 3; # global statusline
      title = true;
      showcmd = false;
    };

    vim.globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
  };
}
