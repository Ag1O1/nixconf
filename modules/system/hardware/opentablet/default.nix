{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.system.hardware.opentablet;
in {
  options.modules.system.hardware.opentablet = {
    enable = lib.mkEnableOption "opentablet";
  };
  config = mkIf cfg.enable {
    hardware.opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };
  };
}
