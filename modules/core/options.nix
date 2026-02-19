{
  flake.modules.nvf.options = {
    vim = {
      clipboard = {
        enable = true;
        registers = "unnamedplus";
      };
      lineNumberMode = "relNumber";
      searchCase = "smart";
      spellcheck = {
        enable = true;
        languages = ["en" "ru"];
      };
      options = {
        expandtab = true;
        autoindent = true;
        shiftwidth = 4;
        wrap = false;
        foldlevel = 999; # disable autofolding

        cursorlineopt = "both";
        signcolumn = "yes";
        fillchars = "eob: ";
        showmode = false;
        ruler = false;
        splitright = true;
        splitbelow = true;
        termguicolors = true;
        title = true;
      };
      globals = {
        mapleader = " ";
        maplocalleader = " ";
      };
    };
  };
}
