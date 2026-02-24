{
  flake.modules.nvf.indent-lines = {
    vim.visuals.indent-blankline = {
      enable = true;
      setupOpts = {
        indent.char = "│";
        scope = {
          show_start = false;
          show_end = false;
        };
      };
    };
  };
}
