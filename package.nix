{
  inputs,
  self,
  ...
}: {
  perSystem = {
    pkgs,
    self',
    ...
  }: {
    packages.nvx =
      (inputs.nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = with self.modules.nvf; [
          init
        ];
      }).neovim;
    packages.default = self'.packages.nvx;
  };

  flake.modules.nvf.init = {
    imports = with self.modules.nvf; [
      core
    ];
  };
}
