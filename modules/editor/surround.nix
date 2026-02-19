{
  flake.modules.nvf.surround = {
    vim.utility.surround = {
      enable = true;
      setupOpts.move_cursor = "sticky";
      setupOpts.keymaps = {
        insert = "<C-g>s";
        insert_line = "<C-g>j";
        normal = "gs";
        normal_cur = "gss";
        normal_line = "gS";
        normal_cur_line = "gSS";
        visual = "gs";
        visual_line = "gS";
        delete = "gsd";
        change = "gsr";
      };
    };
  };
}
