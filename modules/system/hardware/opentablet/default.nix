{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.hardware.opentablet;
in {
  options.modules.hardware.opentablet = {
    enable = lib.mkEnableOption "opentablet";
  };
  config = mkIf cfg.enable {
    hardware.opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };
  };
}
