{
  flake.modules.nvf.lsp = {options, ...}: {
    vim.lsp = {
      enable = true;
      formatOnSave = true;

      # NOTE: mappings follow neovim's default lsp mapping scheme ('gr' prefix)
      mappings = let
        # remove all nvf's default lsp mappings
        resetDefaults = options.vim.lsp.mappings |> builtins.mapAttrs (_: _: null);
      in
        resetDefaults
        // {
          goToDefinition = "grd";
          goToDeclaration = "grD";
          format = "grf";
          hover = "K";
        };
    };
  };
}
