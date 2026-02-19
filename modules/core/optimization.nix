{
  flake.modules.nvf.optimization = {lib, ...}: {
    vim.enableLuaLoader = true;
    vim.globals = let
      inherit (lib) map nameValuePair listToAttrs;
      disabledPlugins = [
        "netrw"
        "netrwPlugin"
        "netrwSettings"
        "netrwFileHandlers"
        "gzip"
        "zip"
        "zipPlugin"
        "tar"
        "tarPlugin"
        "getscript"
        "getscriptPlugin"
        "vimball"
        "vimballPlugin"
        "2html_plugin"
        "logipat"
        "rrhelper"
        "spellfile_plugin"
        "matchit"
      ];
    in
      disabledPlugins
      |> map (plugin: nameValuePair "loaded_${plugin}" 1)
      |> listToAttrs;
  };
}
