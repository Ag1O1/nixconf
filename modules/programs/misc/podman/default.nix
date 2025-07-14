{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.misc.podman;
in {
  options.modules.programs.misc.podman = {
    enable = lib.mkEnableOption "podman";
  };
  config = mkIf cfg.enable {
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
    };
  };
}
