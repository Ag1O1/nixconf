{ config, ... }:
let
  inherit (config.theme) colors fonts;
in
''
  font-family = ${fonts.monospace.name}
  theme = ${colors}
''
