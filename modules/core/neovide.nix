{
  flake.modules.nvf.neovide = {
    pkgs,
    lib,
    ...
  }: let
    inherit (lib.nvim.dag) entryBefore;
    keymapPrefix =
      if pkgs.stdenv.isDarwin
      then "D" # option on darwin
      else "C-S"; # ctrl+shift everywhere else
  in {
    vim.luaConfigRC.neovide = entryBefore ["lazyConfigs"] ''
      if vim.g.neovide then
        vim.opt.linespace = 13

        vim.g.neovide_padding_top = 10
        vim.g.neovide_padding_bottom = 10
        vim.g.neovide_padding_right = 10
        vim.g.neovide_padding_left = 10

        vim.g.neovide_scroll_animation_length = 0.1
        vim.g.neovide_scroll_animation_far_lines = 3

        vim.g.neovide_cursor_animation_length = 0.150
        vim.g.neovide_cursor_short_animation_length = 0.04
        vim.g.neovide_cursor_trail_size = 1.0
        vim.g.neovide_cursor_smooth_blink = true

        vim.g.neovide_floating_shadow = false

        vim.keymap.set('n', '<${keymapPrefix}-n>', function()
            vim.uv.spawn('neovide', { detached = true }, function() end)
        end, { silent = true })

        -- paste in insert mode keymap
        vim.keymap.set(
            { 'n', 'v', 's', 'x', 'o', 'i', 'l', 'c', 't' },
            '<${keymapPrefix}-v>',
            function() vim.api.nvim_paste(vim.fn.getreg('+'), true, -1) end,
            { noremap = true, silent = true }
        )

        -- interpret right option as meta on darwin (left one is used as yabai super key)
        vim.g.neovide_input_macos_option_key_is_meta = 'right_only'
      end
    '';
  };
}
