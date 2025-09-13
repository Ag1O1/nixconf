{pkgs, ...}: {
  qt = {
    enable = true;
    #style = "kvantum";
    style = "gtk2"; #if theme doesn't have kvantum version
    platformTheme = "qt5ct";
  };
  hj = {
    packages = [
      (pkgs.catppuccin-kvantum.override {
        variant = "mocha";
        accent = "blue";
      })
      (pkgs.catppuccin-kde.override {
        flavour = ["mocha"];
        accents = ["blue"];
      })
    ];
  };
}
