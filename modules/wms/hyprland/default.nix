{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.wms.hyprland;
  pkgs-unstable = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  imports = [./config];
  options.modules.wms.hyprland = {
    enable = lib.mkEnableOption "hyprland";
  };
  config = mkIf cfg.enable {
    hj.packages = [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
      pkgs.nautilus # Apparently required for file picking
      pkgs.wlsunset
      pkgs.app2unit
    ];
    hj.rum.desktops.hyprland = {
      #plugins = [pkgs.hyprlandPlugins.hyprsplit];
      enable = true;
    };
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    hardware.graphics = {
      package = pkgs-unstable.mesa;

      enable32Bit = true;
      package32 = pkgs-unstable.pkgsi686Linux.mesa;
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
