{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (config.theme) fonts cursor;
  inherit (builtins) toString;
in ''

  border-radius=2
  default-timeout=2500
  layer=overlay
  actions=1
  history=1
  icon-border-radius=15
  background-color=#181825b3
  border-color=#74c7ece6
  text-alignment=center
  height=125
  width=350
  text-color=#cdd6f4FF
  padding=6
  border-size=3
  icon-location=left
  max-icon-size=64
  font=${fonts.sans.name} 13
''
