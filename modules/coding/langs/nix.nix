{
  flake.modules.nvf.nix = {lib, ...}: let
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
        servers = ["nil"];
      };
      treesitter.enable = true;
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
