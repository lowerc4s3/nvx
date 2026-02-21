{
  flake.modules.nvf.tabout = {pkgs, ...}: {
    # tabout requires treesitter
    vim.treesitter.enable = true;
    vim.lazy.plugins."tabout.nvim" = {
      package = pkgs.vimPlugins.tabout-nvim;
      priority = 1000;
      event = ["InsertEnter" "CmdLineEnter"];
      setupModule = "tabout";
      setupOpts.tabouts = let
        pair = open: close: {inherit open close;};
      in [
        (pair "\"" "\"")
        (pair "'" "'")
        (pair "`" "`")
        (pair "(" ")")
        (pair "[" "]")
        (pair "{" "}")
        (pair "<" ">")
      ];
    };
  };
}
