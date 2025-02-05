{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.theming.qt;
in {
  options.modules.theming.qt = {
    enable = lib.mkEnableOption "qt";
  };
  config = mkIf cfg.enable {
    # TODO: fix qt
    qt = {
      enable = true;
      platformTheme = "qt5ct";
      style = "kvantum";
    };
    environment.systemPackages = [
      #temp
    ];
  };
}
