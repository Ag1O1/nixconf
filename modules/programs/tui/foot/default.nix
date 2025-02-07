{
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
    # FIXME: for some reason this modules isn't generating a foot.ini

    programs.foot = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      theme = "catppuccin-mocha";
      settings = {
        main = {
          font = "${fonts.monospace.name}:size=14";
        };
        scrollback = {
          lines = 100000;
        };

        # TODO: use colors
        colors = with colors; {
          /*
          foreground = base05;
          background = base00;
          regular0 = base00; # black
          regular1 = base08; # red
          regular2 = base0B; # green
          regular3 = base0A; # yellow
          regular4 = base0D; # blue
          regular5 = base0E; # magenta
          regular6 = base0C; # cyan
          regular7 = base05; # white
          bright0 = base02; # bright black
          bright1 = base12; # bright red
          bright2 = base14; # bright green
          bright3 = base13; # bright yellow
          bright4 = base16; # bright blue
          bright5 = base17; # bright magenta
          bright6 = base15; # bright cyan
          bright7 = base07; # bright white
          "16" = base09;
          "17" = base0F;
          "18" = base01;
          "19" = base02;
          "20" = base04;
          "21" = base06;
          /*
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
          */
          alpha = 0.9;
        };
      };
    };
  };
}
