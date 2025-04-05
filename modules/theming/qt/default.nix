{pkgs, ...}: {
  environment.variables.QT_STYLE_OVERRIDE = "kvantum-dark";

  hj.packages = [
    (pkgs.catppuccin-kde.override {
      flavour = ["mocha"];
      accents = ["blue"];
    })
  ];
}
