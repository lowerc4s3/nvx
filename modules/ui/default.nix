{self, ...}: {
  flake.modules.nvf.ui = {
    vim.theme = {
      enable = true;
      style = "dark";
      name = "oxocarbon";
    };

    imports = with self.modules.nvf; [
      icons
      telescope
      colorizer
    ];
  };
}
