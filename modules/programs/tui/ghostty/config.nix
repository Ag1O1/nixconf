{ config, ... }:
let
  inherit (config.theme) colors fonts;
in
''
  font-family = ${fonts.monospace.name}
  font-size = 1x4
  theme = catppuccin-mocha
''
