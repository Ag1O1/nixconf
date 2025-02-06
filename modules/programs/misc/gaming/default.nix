{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.misc.gaming;
in {
  options.modules.programs.misc.gaming = {
    enable = lib.mkEnableOption "gaming";
  };
  config = mkIf cfg.enable {
    programs.steam.enable = true;
    programs.steam.gamescopeSession.enable = true;
    environment.systemPackages = with pkgs; [
      mangohud
      lutris
      wineWowPackages.waylandFull
      winetricks
    ];

    programs.gamemode.enable = true;
  };
}
