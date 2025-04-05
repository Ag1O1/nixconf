{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.hyprland;
  pkgs-unstable = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  imports = [./config];
  options.modules.hyprland = {
    enable = lib.mkEnableOption "hyprland";
  };
  config = mkIf cfg.enable {
    hj.rum.programs.hyprland = {
      plugins = [pkgs.hyprlandPlugins.hyprsplit];
      enable = true;
    };
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
        pkgs.xdg-desktop-portal-gnome
      ];
      config = {
        common.default = ["gtk" "hyprland"];
      };
    };
  };
}
