{
  flake.modules.nvf.ts-textobjects = {
    lib,
    pkgs,
    ...
  }: let
    inherit (lib.nvim.binds) mkKeymap;
    inherit (lib) mapAttrsToList;
    inherit (lib.nvx.lua) mkLambda;
  in {
    vim.treesitter.enable = true;
    vim.lazy.plugins.nvim-treesitter-textobjects = {
      package = pkgs.vimPlugins.nvim-treesitter-textobjects;
      setupModule = "nvim-treesitter-textobjects";
      setupOpts.select = {
        lookahead = true;
        selection_modes = {
          "@function.outer" = "V";
          "@loop.outer" = "V";
          "@condition.outer" = "V";
          "@class.outer" = "V";
          "@comment.outer" = "V";
        };
      };
      keys = let
        selectObjects = {
          "af" = "@function.outer";
          "if" = "@function.inner";
          "al" = "@loop.outer";
          "il" = "@loop.inner";
          "ai" = "@condition.outer";
          "ii" = "@condition.inner";
          "ac" = "@class.outer";
          "ic" = "@class.inner";
          "aC" = "@comment.outer";
          "iC" = "@comment.inner";
          "aP" = "@parameter.outer";
          "iP" = "@parameter.inner";
        };
        select = capture:
          mkLambda ({}: ''
            require('nvim-treesitter-textobjects.select')
              .select_textobject('${capture}', 'textobjects')
          '');
      in
        selectObjects
        |> mapAttrsToList (lhs: capture: mkKeymap ["x" "o"] lhs (select capture) {lua = true;});
    };
  };
}
