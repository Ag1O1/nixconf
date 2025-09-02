{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.gui.fuzzel;
  inherit (config.theme) fonts colors;
in {
  options.modules.programs.gui.fuzzel = {
    enable = lib.mkEnableOption "fuzzel";
  };
  config = mkIf cfg.enable {
    hj.rum.programs.fuzzel = {
      enable = true;
      package = pkgs.fuzzel;
      settings = {
        main = {
          terminal = "foot -e";
          icon-theme = "Dracula";
          dpi-aware = "no";
          width = "20";
          font = "${fonts.sans.name}weight:bold:size=10";
          line-height = "20";
          fields = "name,generic,comment,categories,filename,keywords";
          prompt = "❯   ";
          show-actions = "yes";
          exit-on-keyboard-focus-loss = "no";
        };
        colors = {
          background = "${colors.base00}ff";
          selection = "${colors.base0B}ff";
          border = "${colors.base0B}ff";
        };
      };
    };
  };
}
