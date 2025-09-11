{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
with lib;
let
  cfg = config.modules.programs.misc.gaming;
in
{
  options.modules.programs.misc.gaming = {
    enable = lib.mkEnableOption "gaming";
  };
  config = mkIf cfg.enable {
    programs.appimage.enable = true;
    programs.steam = {
      enable = true;
      package = pkgs.steam.override {
        extraPkgs =
          pkgs: with pkgs; [
            # Workaround xorg cursor issue
            bibata-cursors
          ];
      };
    };
    programs.steam.gamescopeSession.enable = true;
    environment.systemPackages = with pkgs; [
      prismlauncher
      love # to run love2d games
      mangohud
      (lutris.override {
        extraPkgs =
          pkgs: with pkgs; [
            # Workaround xorg cursor issue
            bibata-cursors
          ];
      })
      (inputs.umu.packages.x86_64-linux.umu-launcher.override {
        extraPkgs =
          pkgs: with pkgs; [
            # Workaround xorg cursor issue
            bibata-cursors
          ];
      })
      winePackages.waylandFull
      (wine.override { wineBuild = "wine64"; })
      winetricks
    ];

    programs.gamemode.enable = true;
  };
}
