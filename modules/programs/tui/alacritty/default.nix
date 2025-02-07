{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.tui.alacritty;
  inherit (config.theme) colors fonts;
in {
  options.modules.programs.tui.alacritty = {
    enable = lib.mkEnableOption "alacritty";
  };
  config = mkIf cfg.enable {
    hj.rum.programs.alacritty = {
      enable = true;
      settings = {
        font = {
          size = fonts.size;
          normal.family = "${fonts.monospace.name}";
        };
        window = {
          dimensions = {
            lines = 28;
            columns = 101;
          };
          padding = {
            x = 6;
            y = 3;
          };
        };
        colors = {
          bright = {
            black = "#${colors.base00}";
            blue = "#${colors.base0D}";
            cyan = "#${colors.base0C}";
            green = "#${colors.base0B}";
            magenta = "#${colors.base0E}";
            red = "#${colors.base08}";
            white = "#${colors.base06}";
            yellow = "#${colors.base09}";
          };
          cursor = {
            cursor = "#${colors.base06}";
            text = "#${colors.base06}";
          };
          normal = {
            black = "#${colors.base00}";
            blue = "#${colors.base0D}";
            cyan = "#${colors.base0C}";
            green = "#${colors.base0B}";
            magenta = "#${colors.base0E}";
            red = "#${colors.base08}";
            white = "#${colors.base06}";
            yellow = "#${colors.base0A}";
          };
          primary = {
            background = "#${colors.base00}";
            foreground = "#${colors.base06}";
          };
        };
      };
    };
  };
}
