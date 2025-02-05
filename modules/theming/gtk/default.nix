{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.theming.gtk;
in {
  options.modules.theming.gtk = {
    enable = lib.mkEnableOption true "gtk";
  };
  config = mkIf cfg.enable {
    # TODO: gtk config
  };
}
