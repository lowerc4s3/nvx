{
  inputs,
  self,
  lib,
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
        extraSpecialArgs = {
          lib = lib.extend (final: prev: {
            inherit (inputs.nvf.lib) nvim;
            nvx = self.lib;
          });
        };
        modules = with self.modules.nvf; [
          init
        ];
      }).neovim;
    packages.default = self'.packages.nvx;
  };

  flake.modules.nvf.init = {
    imports = with self.modules.nvf; [
      core
      editor
      coding
      nix
    ];
  };
}
