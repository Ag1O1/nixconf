{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.gui.walker;
in {
  options.modules.programs.gui.walker = {
    enable = lib.mkEnableOption "walker";
  };
  imports = [inputs.walker.nixosModules.default];
  config = mkIf cfg.enable {
    programs.walker = {
      enable = true;
      runAsService = true;
    };

    nix.settings = {
      substituters = ["https://walker.cachix.org"];
      trusted-public-keys = ["walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="];
    };
  };
}
