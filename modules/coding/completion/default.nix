{self, ...}: {
  flake.modules.nvf.completion.imports = with self.modules.nvf; [
    blink
  ];
}
