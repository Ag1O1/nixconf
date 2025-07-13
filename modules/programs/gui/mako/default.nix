{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.programs.gui.mako;
  mako-config = import ./config.nix { inherit pkgs lib config; }
in
{
  options.modules.programs.gui.mako = {
    enable = lib.mkEnableOption "mako";
  };

  config = mkIf cfg.enable {
    hj = {
      packages = [
        pkgs.mako
      ];
      files = {
        ".config/mako/config".text = mako-config;
      };
    };
  };
}
