{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.programs.gui.noctalia;
in {
  options.modules.programs.gui.noctalia = {
    enable = lib.mkEnableOption "noctalia shell";
  };

  config = mkIf cfg.enable {
    services.upower.enable = true; # Required to change power profiles
    services.power-profiles-daemon.enable = true;
    hj = {
      packages = [
        inputs.noctalia.packages.${pkgs.system}.default
        inputs.quickshell.packages.${pkgs.system}.default
        inputs.matugen.packages.${pkgs.system}.default
        pkgs.wlsunset
        pkgs.app2unit
        pkgs.glib
      ];
    };
  };
}
