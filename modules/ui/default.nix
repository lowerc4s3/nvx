{self, ...}: {
  flake.modules.nvf.ui.imports = with self.modules.nvf; [
    icons
  ];
}
