{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.tui.foot;
  inherit (config.theme) colors fonts;
in {
  options.modules.programs.tui.foot = {
    enable = lib.mkEnableOption "foot";
  };
  config = mkIf cfg.enable {
    programs.foot = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      theme = "catppuccin-mocha";
      settings = {
        main = {
          font = "${fonts.monospace.name}:size=${toString fonts.size}";
        };
        colors = with colors; {
          background = base00; # base color
          foreground = base05; # text color

          regular0 = base03; # black
          regular1 = base08; # red
          regular2 = base0B; # green
          regular3 = base0A; # yellow
          regular4 = base0D; # blue
          regular5 = base0F; #magenta
          regular6 = base0C; #cyan
          regular7 = base06; #white

          bright0 = base04; # Surface 2
          bright1 = base08; # red
          bright2 = base0B; # green
          bright3 = base0A; # yellow
          bright4 = base0D; # blue
          bright5 = base0F; # pink
          bright6 = base0C; # teal
          bright7 = base07; # Subtext 0

          alpha = 0.85;
        };
      };
    };
  };
}
