{
  flake.modules.nvf.colorizer = {pkgs, ...}: {
    vim.lazy.plugins."nvim-colorizer.lua" = {
      package = pkgs.vimPlugins.nvim-colorizer-lua;
      setupModule = "colorizer";
      setupOpts.user_default_options = {
        names = false;
        mode = "virtualtext";
        virtualtext = "";
        virtualtext_inline = "before";
        RGB = false;
        RGBA = false;
      };
    };
  };
}
