{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.tui.starship;
in {
  options.modules.programs.tui.starship = {
    enable = lib.mkenableoption "starship";
  };
  config = mkif cfg.enable {
    hj.rum.programs.starship = {
      enable = true;
      settings = {
        add_newline = false;
        format = lib.concatStrings [
          "$line_break"
          "$package"
          "$line_break"
          "$character"
        ];
        scan_timeout = 10;
        character = {
          success_symbol = "➜";
          error_symbol = "➜";
        };
      };
      integrations = {
            fish.enable = true;
      };
    };
  };
}
