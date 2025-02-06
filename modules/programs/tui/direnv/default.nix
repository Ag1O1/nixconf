{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.tui.direnv;
in {
  options.modules.programs.tui.direnv = {
    enable = lib.mkEnableOption "direnv";
  };
  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
  };
}
