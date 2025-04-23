{ pkgs, ... }:
{
  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "kvantum";
  };

  hj.packages = [
    (pkgs.catppuccin-kde.override {
      flavour = [ "mocha" ];
      accents = [ "blue" ];
    })
  ];
}
