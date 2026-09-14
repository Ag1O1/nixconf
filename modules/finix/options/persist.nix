{lib, ...}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) listOf anything;
in {
  options.custom.persist = {
    files = mkOption {
      type = listOf anything;
      default = [];
      description = "Files to persist";
    };
    directories = mkOption {
      type = listOf anything;
      default = [];
      description = "Directories to persist";
    };
  };
}
