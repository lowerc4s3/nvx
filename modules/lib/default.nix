{lib, ...}: {
  options.flake.lib = lib.mkOption {
    type = with lib.types; attrsOf unspecified;
    default = {};
  };

  config.flake.lib = {
    mkAutocmd = events: opts: opts // {event = lib.toList events;};

    # returns nixpkgs' plugin without dependencies. exists as a workaround for
    # duplicate plugins in /start and /opt.
    withoutDeps = pkg:
      pkg.overrideAttrs {
        dependencies = [];
      };
  };
}
