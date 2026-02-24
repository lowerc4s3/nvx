{
  flake.modules.nvf.nix = {
    lib,
    pkgs,
    ...
  }: let
    inherit (lib.nvx) mkAutocmd;
    inherit (lib.generators) mkLuaInline;
  in {
    vim.languages.nix = {
      enable = true;
      format = {
        enable = true;
        type = ["alejandra"];
      };
      lsp = {
        enable = true;
        servers = ["nixd"];
      };
      treesitter = {
        enable = true;
        package = pkgs.vimPlugins.nvim-treesitter-parsers.nix;
      };
    };
    vim.autocmds = [
      (mkAutocmd "FileType" {
        pattern = ["nix"];
        callback = mkLuaInline ''
          function(opts)
            local bo = vim.bo[opts.buf]
            bo.tabstop = 2
            bo.shiftwidth = 2
          end
        '';
      })
    ];
  };
}
