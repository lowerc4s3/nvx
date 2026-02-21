{
  flake.modules.nvf.lsp = {
    options,
    lib,
    nvxlib,
    ...
  }: let
    inherit (lib.nvim.dag) entryAfter;
    inherit (nvxlib.lua) createAutocmd mkLambda;
  in {
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

    # setup symbol references highlight
    vim.luaConfigRC.lsp-doc-highlight = entryAfter ["lsp-setup"] ''
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-doc-highlight', { clear = true }),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if not client then return end

          if client:supports_method(
            vim.lsp.protocol.Methods.textDocument_documentHighlight,
            event.buf
          ) then
            local hl_augroup = vim.api.nvim_create_augroup('word-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = hl_augroup,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('word-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'word-lsp-highlight', buffer = event2.buf }
              end,
            })
          end
        end,
      })
    '';
  };
}
