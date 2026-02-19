{
  flake.modules.nvf.leap = {
    lib,
    nvxlib,
    ...
  }: let
    inherit (lib.nvim.binds) mkKeymap;
    inherit (nvxlib.lua) mkFunc mkLambda;
    inherit (lib.nvim.dag) entryBefore;
    remoteTextObject = mkFunc "remoteTextObject" ({prefix}: ''
      local ok, ch = pcall(vim.fn.getcharstr) -- pcall for handling <C-c>
      if not ok or (ch == vim.keycode('<esc>')) then return end
      require('leap.remote').action { input = ${prefix} .. ch }
    '');
  in {
    vim.startPlugins = ["vim-repeat"];
    vim.luaConfigRC.leap-nvim =
      entryBefore ["mappings"]
      remoteTextObject.definition;
    vim.lazy.plugins.leap-nvim = {
      package = "leap-nvim";
      lazy = false; # leap.nvim lazy loads itself
      keys = [
        (mkKeymap ["n" "x" "o"] "s" "<Plug>(leap)" {})
        (mkKeymap "n" "S" "<Plug>(leap-from-window)" {})
        (mkKeymap ["x" "o"] "ar" (remoteTextObject.lambda ["a"]) {lua = true;})
        (mkKeymap ["x" "o"] "ir" (remoteTextObject.lambda ["i"]) {lua = true;})
      ];
    };
  };
}
