{ config, ... }:
let
  inherit (config.theme) colors fonts;
in
''
  font-family = ${fonts.monospace.name}
  font-size = 14
  theme = catppuccin-mocha
''
