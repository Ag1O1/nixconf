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
    hj.files = {
      #".config/hypr".source = pkgs.writeTextFile "hyprland.conf" [./hyprland.conf];
      ".config/hypr/hyprland.conf".text = builtins.readFile ./hyprland.conf;
      #".config/bar".source = pkgs.writeTextFile "file-foo" "file contents";
    };
  };
}
