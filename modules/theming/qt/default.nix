{ pkgs, ... }:
{
  qt = {
    enable = true;
    style = "kvantum";
    platformTheme = "qt5ct";
  };
  hj = {
    packages = [
      (pkgs.catppuccin-kvantum.override {
        variant = "mocha";
        accent = "blue";
      })
      (pkgs.catppuccin-kde.override {
        flavour = [ "mocha" ];
        accents = [ "blue" ];
      })
    ];

  };
}
