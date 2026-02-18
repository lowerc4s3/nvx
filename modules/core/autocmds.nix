{
  flake.modules.nvf.autocmds = {
    lib,
    nvxlib,
    ...
  }: let
    inherit (nvxlib) mkAutocmd;
  in {
    vim.autocmds = [
      (mkAutocmd "FileType" {
        desc = "quit help pages with 'q'";
        pattern = ["help" "qf" "man"];
        command = "nnoremap <silent> <buffer> q :close<CR>";
      })
    ];
  };
}
