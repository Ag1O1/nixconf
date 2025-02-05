{
  inputs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.theming.nix-colors;
in {
  options.modules.theming.nix-colors = {
    enable = lib.mkEnableOption true "nix-colors";
  };
  config = mkIf cfg.enable {
    imports = [
      inputs.nix-colors.homeManagerModules.default
    ];

    colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;
  };
}
