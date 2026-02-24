{
  flake.modules.nvf.telescope = {
    lib,
    pkgs,
    options,
    ...
  }: let
    inherit (lib.generators) mkLuaInline;
    inherit (lib.nvim.binds) mkKeymap;
    inherit (lib.nvx) withoutDeps;
  in {
    vim.telescope = {
      enable = true;

      setupOpts.defaults = {
        prompt_prefix = "  ";
        selection_caret = " ";
        entry_prefix = " ";
        results_title = false;
        dynamic_preview_title = true;

        # remove borders
        borderchars = builtins.genList (_: " ") 8;

        layout_config.horizontal = {
          prompt_position = "top";
          preview_width = 0.5;
        };

        # leave the prompt by pressing esc
        mappings.i = {
          "<esc>" = mkLuaInline ''require("telescope.actions").close'';
          "<C-j>" = mkLuaInline ''require("telescope.actions").move_selection_next'';
          "<C-k>" = mkLuaInline ''require("telescope.actions").move_selection_previous'';
        };
      };

      mappings = options.vim.telescope.mappings |> builtins.mapAttrs (_: _: null);

      extensions = [
        {
          name = "fzf";
          packages = [(withoutDeps pkgs.vimPlugins.telescope-fzf-native-nvim)];
        }
        # {
        #   name = "ui-select";
        #   packages = [pkgs.vimPlugins.telescope-ui-select-nvim];
        #   setup = toLuaObject ;
        # }
      ];
    };
    vim.keymaps = [
      (mkKeymap "n" "<leader>ff" "<cmd>Telescope find_files<cr>" {desc = "Search files";})
      (mkKeymap "n" "<leader><leader>" "<cmd>Telescope find_files<cr>" {desc = "Search files";})
      (mkKeymap "n" "<leader>fr" "<cmd>Telescope oldfiles<cr>" {desc = "Search recents";})
      (mkKeymap "n" "<leader>fb" "<cmd>Telescope buffers<cr>" {desc = "Search buffers";})
      (mkKeymap "n" "<leader>fw" "<cmd>Telescope live_grep<cr>" {desc = "Grep files";})

      # TODO: check for telescope and project.nvim
      # (mkKeymap "n" "<leader>fp" "<cmd>Telescope projects<cr>" {desc = "Search projects";})
    ];
    vim.highlight = {
      TelescopeNormal.link = "Pmenu";
      TelescopePromptNormal.link = "PmenuSel";
      TelescopePromptBorder.link = "PmenuSel";
      TelescopePromptPrefix.link = "PmenuSel";
      TelescopePreview.link = "Pmenu";
      TelescopePreviewBorder.link = "Pmenu";
      TelescopeResults.link = "Pmenu";
      TelescopeResultsBorder.link = "Pmenu";
    };
  };
}
