{
  flake.modules.nvf.blink = {
    lib,
    options,
    config,
    ...
  }: let
    inherit (lib.nvim.lua) toLuaObject;
    inherit (lib.generators) mkLuaInline;
    mkLuaLambda = func: mkLuaInline (lib.nvx.lua.mkLambda func);
  in {
    vim.autocomplete.blink-cmp = {
      enable = true;
      mappings = {
        scrollDocsUp = "<C-b>";
        scrollDocsDown = "<C-f>";
      };
      setupOpts = {
        sources.default = ["snippets" "lsp" "path" "buffer"];

        appearance.nerd_font_variant = "normal";
        signature.enabled = true;

        completion = {
          documentation.auto_show = true;
          trigger.show_on_backspace = true;
          list.selection = {
            preselect = false;
            auto_insert = true;
          };

          # NOTE: Enabling this causes buggy cursor jumps on Neovide v0.15.0 or earlier
          accept.dot_repeat = true;

          menu.draw = {
            padding = [0 1];

            columns =
              lib.mkIf config.vim.ui.colorful-menu-nvim.enable
              ["kind_icon" (toLuaObject "{ 'label', gap = 1 }")];

            components.label = lib.mkIf config.vim.ui.colorful-menu-nvim.enable {
              text = mkLuaLambda ({ctx}: ''
                return require ('colorful-menu').blink_components_text(${ctx})
              '');
              highlight = mkLuaLambda ({ctx}: ''
                return require('colorful-menu').blink_components_highlight(${ctx})
              '');
            };

            components.kind_icon.text =
              lib.mkIf config.vim.mini.icons.enable
              (mkLuaLambda ({ctx}: ''
                return ' '
                    .. require('mini.icons').get('lsp', ctx.kind)
                    .. ctx.icon_gap
              ''));
          };
        };

        cmdline = {
          keymap = {
            preset = "inherit";
            "<CR>" = ["accept_and_enter" "fallback"];
          };
          completion = {
            menu.auto_show = true;
            list.selection = {
              preselect = false;
              auto_insert = true;
            };
            ghost_text.enabled = false;
          };
        };
      };
    };
  };
}
