{self, ...}: {
  flake.modules.nvf.editor = {
    imports = with self.modules.nvf; [
      leap
      langinput
      surround
      autopairs
    ];
  };
}
