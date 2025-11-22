{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.tui.ghostty;
  inherit (config.theme) colors fonts;
in {
  options.modules.programs.tui.ghostty = {
    enable = lib.mkEnableOption "ghostty";
  };
  config = lib.mkIf cfg.enable {
    hj.rum.programs.ghostty = {
      enable = true;
      settings = {
        font-family = fonts.monospace.name;
        font-size = 14;
        theme = "custom";
        working-directory = "home";
        window-inherit-working-directory = false;
      };
      themes = {
        custom = {
          palette = [
            "0=${colors.base03}" # black
            "1=${colors.base08}" # red
            "2=${colors.base0B}" # green
            "3=${colors.base0A}" # yellow
            "4=${colors.base0D}" # blue
            "5=${colors.base0F}" # magenta
            "6=${colors.base0C}" # cyan
            "7=${colors.base06}" # white
            "8=${colors.base04}" # Surface 2
            "9=${colors.base08}" # red
            "10=${colors.base0B}" # green
            "11=${colors.base0A}" # yellow
            "12=${colors.base0D}" # blue
            "13=${colors.base0F}" # pink
            "14=${colors.base0C}" # teal
            "15=${colors.base07}" # Subtext 0
          ];
          background = colors.base00; # base color
          foreground = colors.base05; # text color
        };
      };
    };
  };
}
