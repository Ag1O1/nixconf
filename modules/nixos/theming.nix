{
  flake.modules.nixos.theming = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.adw-gtk3
      pkgs.dracula-icon-theme
      pkgs.papirus-icon-theme
      pkgs.bibata-cursors
      pkgs.xsettingsd
      pkgs.xorg.xrdb
    ];
    environment.sessionVariables = {
      GTK_THEME = "adw-gtk3";
    };
    qt = {
      enable = true;
      platformTheme = "qt5ct";
    };
  };
}
