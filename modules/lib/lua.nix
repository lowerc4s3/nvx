{
  lib,
  self,
  ...
}: let
  mkFuncParts = func: let
    args' =
      builtins.functionArgs func
      |> lib.attrNames
      |> lib.map (arg: lib.nameValuePair arg arg)
      |> lib.listToAttrs;
  in {
    args = lib.attrNames args' |> lib.join ", ";
    body = func args';
  };

  mkCall = name: args: let
    inherit (lib) map isString join;
    escapeStrings = arg:
      if (isString arg)
      then (lib.strings.escapeNixString arg)
      else arg;
    args' = args |> map escapeStrings |> join ", ";
  in ''
    ${name}(${args'})
  '';
in {
  flake.lib.lua = {
    mkFunc = name: fn: let
      funcParts = mkFuncParts fn;
    in {
      definition = ''
        local function ${name}(${funcParts.args})
          ${funcParts.body}
        end
      '';
      call = mkCall name;
      lambda = args: self.lib.lua.mkLambda ({}: mkCall name args);
    };

    mkLambda = fn: let
      funcParts = mkFuncParts fn;
    in ''
      function(${funcParts.args})
        ${funcParts.body}
      end
    '';
  };
}
