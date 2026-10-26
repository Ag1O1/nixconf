{
  tags = ["gaming"];
  module = {
    inputs,
    system,
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
      package = inputs.millennium.packages."${system}".millennium-steam;
    };
    hj.packages = [
      (pkgs.prismlauncher.override {
        jdks = [pkgs.jdk25];
      })
      pkgs.appimage-run
      pkgs.love # to run love2d games
      pkgs.mangohud
      #pkgs.lutris
      pkgs.faugus-launcher
      pkgs.umu-launcher
      (pkgs.winePackages.waylandFull.override {wineBuild = "wine64";})
      pkgs.winetricks
    ];

    programs.gamemode.enable = true;
  };
}
