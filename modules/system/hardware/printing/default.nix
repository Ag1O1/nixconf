{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.system.hardware.printing;
in {
  options.modules.system.hardware.printing = {
    enable = lib.mkEnableOption "printing";
  };
  config = mkIf cfg.enable {
    services.printing = {
      enable = true;
      drivers = [pkgs.hplipWithPlugin];
    };
    hardware.sane = {
      enable = true;
      extraBackends = [pkgs.hplipWithPlugin];
    };
  };
}
