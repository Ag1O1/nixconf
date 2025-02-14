{pkgs, ...}: {
  environment.variables.QT_STYLE_OVERRIDE = "Catppuccin-Macchiato-Dark";

  hj.packages = [
    (pkgs.catppuccin-kde.override {
      flavour = ["mocha"];
      accents = ["blue"];
    })
  ];
}
