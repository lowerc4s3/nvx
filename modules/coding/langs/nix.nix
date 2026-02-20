{
  flake.modules.nvf.nix = {
    vim.languages.nix = {
      enable = true;
      format = {
        enable = true;
        type = ["alejandra"];
      };
      lsp = {
        enable = true;
        servers = ["nil"];
      };
      treesitter.enable = true;
    };
  };
}
