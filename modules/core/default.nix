{self, ...}: {
  flake.modules.nvf.core.imports = with self.modules.nvf; [
    options
    keymaps
    autocmds
    optimization
    neovide
  ];
}
