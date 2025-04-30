{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.programs.tui.ghostty;
  ghostty-config = import ./config.nix { inherit config; };
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
        ".config/ghostty/config".text = ghostty-config;
      };
    };
  };
}
