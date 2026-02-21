{self, ...}: {
  flake.modules.nvf.coding.imports = with self.modules.nvf; [
    lsp
    autoformat
    completion
  ];
}
