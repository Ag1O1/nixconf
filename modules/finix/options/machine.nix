{lib, ...}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) enum str attrsOf submodule bool listOf;
in {
  options.custom.machine = {
    type = mkOption {
      type = enum ["desktop" "laptop"];
      description = "Type of the machine";
    };
    displays = mkOption {
      type = attrsOf (submodule {
        options = {
          mode = mkOption {
            type = str;
            default = "1980x1080@60";
          };
          vrr = mkOption {
            type = enum ["always" "disabled" "fullscreen"];
            default = "disabled";
          };
          direct_scanout = mkOption {
            type = bool;
            default = false;
          };
        };
      });
    };
    drm_ignored_pci_addresses = mkOption {
      type = listOf str;
      default = [];
    };
  };
}
