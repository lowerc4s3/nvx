{
  flake.modules.nvf.autopairs = {
    vim.lazy.plugins.mini-pairs = {
      package = "mini-pairs";
      event = "InsertEnter";
      setupModule = "mini.pairs";
      setupOpts = {};
    };
  };
}
