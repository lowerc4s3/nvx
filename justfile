alias show := print-config

print-config:
    nix run ".#nvx.nvfPrintConfig" | bat --language=lua

run file:
    nix run . -- {{file}}
