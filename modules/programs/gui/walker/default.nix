{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.gui.spicetify;
in {
  options.modules.programs.gui.spicetify = {
    enable = lib.mkEnableOption "spicetify";
  };
  imports = [inputs.spicetify-nix.nixosModules.default];
  config = mkIf cfg.enable {
    imports = [inputs.walker.NixosModules.default];
    programs.walker = {
      enable = true;
      runAsService = true;
    };
  };
}
