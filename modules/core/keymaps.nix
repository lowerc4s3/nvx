{
  flake.modules.nvf.keymaps = {lib, ...}: let
    inherit (lib.nvim.binds) mkKeymap;
  in {
    vim.keymaps = [
      (mkKeymap ["n" "v"] "<space>" "<nop>" {desc = "disable space mapping";})
      (mkKeymap "v" "y" "ygv<esc>" {desc = "make cursor stay when yanking in visual mode";})

      (mkKeymap "i" "<c-h>" "<left>" {desc = "move right";})
      (mkKeymap "i" "<c-j>" "<down>" {desc = "move down";})
      (mkKeymap "i" "<c-k>" "<up>" {desc = "move up";})
      (mkKeymap "i" "<c-l>" "<right>" {desc = "move right";})

      (mkKeymap "n" "<c-h>" "<c-w>h" {desc = "move to the left window";})
      (mkKeymap "n" "<c-j>" "<c-w>j" {desc = "move to the lower window";})
      (mkKeymap "n" "<c-k>" "<c-w>k" {desc = "move to the upper window";})
      (mkKeymap "n" "<c-l>" "<c-w>l" {desc = "move to the right window";})

      (mkKeymap "n" "<esc>" "<cmd>noh<cr>" {desc = "disable search highlight";})
      (
        mkKeymap "n" "@"
        ''<cmd>execute "noautocmd norm!" . v:count1 . "@" . getcharstr()<CR>"''
        {desc = "instant macros";}
      )
    ];
  };
}
