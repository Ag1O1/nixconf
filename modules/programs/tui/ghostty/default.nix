{ config, lib, ... }:
with lib;
let
  cfg = config.modules.programs.tui.ghostty;
in
{
  options.modules.programs.tui.ghostty = {
    enable = lib.mkEnableOption "ghostty";
  };
  config = lib.mkIf cfg.enable {
    hj = {
      packages = [
        pkgs.ghostty
      ];
      files = {
        ".config/ghostty/config".text = "";
      };
    };
  };
}
