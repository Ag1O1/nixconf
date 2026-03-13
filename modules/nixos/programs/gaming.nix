{
  flake.modules.nixos.gaming = {pkgs, ...}: {
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
      pkgs.lutris
      pkgs.umu-launcher
      (pkgs.winePackages.waylandFull.override {wineBuild = "wine64";})
      pkgs.winetricks
    ];

    programs.gamemode.enable = true;
  };
}
