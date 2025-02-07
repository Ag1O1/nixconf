{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.misc.git;
in {
  options.modules.programs.misc.git = {
    enable = lib.mkEnableOption "git";
  };
  config = mkIf cfg.enable {
    programs.git.enable = true;
  };
}
