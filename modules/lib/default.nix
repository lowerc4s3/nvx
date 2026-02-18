{lib, ...}: {
  options.flake.lib = lib.mkOption {
    type = with lib.types; attrsOf unspecified;
    default = {};
  };

  config.flake.lib = {
    mkAutocmd = events: opts: opts // {event = lib.toList events;};
  };
}
