{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.programs.gui.obs;
in
{
  options.modules.programs.gui.obs = {
    enable = lib.mkEnableOption "obs studio";
  };
  config = mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;
      enableVirtualCamera = true;
      plugins = [
        pkgs.obs-studio-plugins.wlrobs
        pkgs.obs-obs-studio-plugins.obs-vaapi
        pkgs.obs-obs-studio-plugins.input-overlay
        pkgs.obs-obs-studio-plugins.vkcapture
      ];
    };
  };
}
