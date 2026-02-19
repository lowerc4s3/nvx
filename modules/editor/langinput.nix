{
  flake.modules.nvf.langinput = {
    lib,
    pkgs,
    ...
  }: let
    inherit (lib.nvim.dag) entryAfter;
    entryBottom = entryAfter [
      "mappings"
      "lazyConfigs"
      "pluginConfigs"
      "extraPluginsConfigs"
    ];
  in {
    vim.options.langmap = let
      en = ''`qwertyuiop[]asdfghjkl\;'zxcvbnm'';
      ru = ''ёйцукенгшщзхъфывапролджэячсмить'';
      enShift = ''~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>'';
      ruShift = ''ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ'';
    in "${ruShift};${enShift},${ru};${en}";

    vim.lazy.plugins."langmapper.nvim" = {
      package = pkgs.vimPlugins.langmapper-nvim;
      lazy = false;
      priority = 1000;
      setupModule = "langmapper";
      setupOpts = {};
    };

    # automapping should be invoked after all keymaps and plugins have loaded
    vim.luaConfigRC."langmapper.nvim" = entryBottom ''
      require("langmapper").automapping { buffer = false }
    '';
  };
}
