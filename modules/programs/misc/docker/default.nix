{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.misc.docker;
in {
  options.modules.programs.misc.docker = {
    enable = lib.mkEnableOption "docker";
  };
  config = mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
    };
  };
}
