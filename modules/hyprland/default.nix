{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.hyprland;
in {
  options.modules.hyprland = {
    enable = lib.mkEnableOption "hyprland";
  };
  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    hardware.graphics = {
      package = pkgs-unstable.mesa.drivers;

      enable32Bit = true;
      package32 = pkgs-unstable.pkgsi686Linux.mesa.drivers;
    };
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
      config = {
        common.default = ["gtk" "hyprland"];
      };
    };
  };
}
