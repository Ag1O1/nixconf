{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.gui.fuzzel;
  inherit (config.theme) fonts colors;
  fuzzle-conf = ''
    dpi-aware=no
    icon-theme=Papirus-Dark
    width=25
    font=${fonts.sans.name}weight:bold:size=36
    line-height=50
    fields=name,generic,comment,categories,filename,keywords
    terminal=foot -e
    prompt="❯   "
    show-actions=yes
    exit-on-keyboard-focus-loss=no
    [colors]
    background=${colors.base00}
    selection=${colors.base0B}
    border=${colors.base0B}

    [border]
    radius=20

    [dmenu]
    exit-immediately-if-empty=yes
  '';
in {
  options.modules.programs.gui.fuzzel = {
    enable = lib.mkEnableOption "fuzzel";
  };
  config = mkIf cfg.enable {
    hj = {
      packages = [pkgs.fuzzel];
      files = {
        "~/.config/fuzzel/fuzzel.ini".text = fuzzle-conf;
      };
    };
  };
}
