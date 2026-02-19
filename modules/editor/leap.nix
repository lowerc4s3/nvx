{
  flake.modules.nvf.leap = {
    lib,
    nvxlib,
    ...
  }: let
    inherit (lib.nvim.binds) mkKeymap;
    inherit (nvxlib.lua) mkFunc mkLambda;
    remoteTextObject = mkFunc "remoteTextObject" ({prefix}: ''
      local ok, ch = pcall(vim.fn.getcharstr) -- pcall for handling <C-c>
      if not ok or (ch == vim.keycode('<esc>')) then return end
      require('leap.remote').action { input = ${prefix} .. ch }
    '');
  in {
    vim.startPlugins = ["vim-repeat"];
    vim.extraPlugins.leap-nvim = {
      package = "leap-nvim";
      setup = remoteTextObject.definition;
    };
    vim.keymaps = [
      (mkKeymap ["n" "x" "o"] "s" "<Plug>(leap)" {})
      (mkKeymap "n" "S" "<Plug>(leap-from-window)" {})
      (mkKeymap ["x" "o"] "ar" (remoteTextObject.lambda ["a"]) {lua = true;})
      (mkKeymap ["x" "o"] "ir" (remoteTextObject.lambda ["i"]) {lua = true;})
    ];
  };
}
