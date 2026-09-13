{
  inputs,
  fm,
  cm,
  pkgs,
  ...
}: {
  imports = [cm.steam fm.gamemode];
  # We use ntsync rather than esync, disable esync in lutris.
  boot.kernelModules = ["ntsync"];
  programs.steam = {
    enable = true;
    package = inputs.millennium.packages."${pkgs.system}".millennium-steam;
    /*
    package = pkgs.steam.override {
      extraPkgs = pkgs:
        with pkgs; [
          # Workaround xorg cursor issue
          bibata-cursors
        ];
    };
    */
  };
  environment.systemPackages = [
    pkgs.prismlauncher # Minecraft
    pkgs.appimage-run
    pkgs.love # to run love2d games
    pkgs.mangohud
    pkgs.lutris
    pkgs.umu-launcher
    (pkgs.winePackages.waylandFull.override {wineBuild = "wine64";})
    pkgs.winetricks
  ];

  programs.gamemode.enable = true;
}
