{
  flake.modules.nvf.icons = {lib, ...}: let
    mkGlyph = targets: icon:
      targets
      |> lib.toList
      |> lib.map (target: lib.nameValuePair target icon)
      |> lib.listToAttrs;
  in {
    vim.mini.icons = {
      enable = true;
      setupOpts.file = lib.mkMerge [
        (mkGlyph ["LICENSE" "LICENSE.md" "LICENSE.txt"] "")
        (mkGlyph ["README" "README.md" "README.txt"] "󰭤")
      ];
      setupOpts.filetype = lib.mkMerge [
        (mkGlyph ["hjson" "json" "json5" "jsonc" "jsonl"] "")
        (mkGlyph "telescopeprompt" "")
        (mkGlyph "typst" "")
      ];
    };
  };
}
