{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.programs.misc.gaming;
  pkgs-stable = import inputs.nixpkgs-stable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in {
  options.modules.programs.misc.gaming = {
    enable = lib.mkEnableOption "gaming";
  };
  config = mkIf cfg.enable {
    programs.appimage.enable = true;
    programs.steam = {
      enable = true;
      package = pkgs.steam.override {
        extraPkgs = pkgs:
          with pkgs; [
            # Workaround xorg cursor issue
            bibata-cursors
          ];
      };
    };
    programs.steam.gamescopeSession.enable = true;
    environment.systemPackages = [
      pkgs.prismlauncher # Minecraft
      pkgs.love # to run love2d games
      pkgs.mangohud
      (pkgs.lutris.override {
        extraPkgs =
          pkgs: with pkgs; [
            # Workaround xorg cursor issue
            bibata-cursors
          ];
      })
      (inputs.umu.packages.x86_64-linux.umu-launcher.override {
        extraPkgs = pkgs:
          with pkgs; [
            # Workaround xorg cursor issue
            bibata-cursors
          ];
      })
      #pkgs.winePackages.waylandFull
      (pkgs.winePackages.waylandFull.override { wineBuild = "wine64"; })
      pkgs.winetricks
    ];

    programs.gamemode.enable = true;
  };
}
