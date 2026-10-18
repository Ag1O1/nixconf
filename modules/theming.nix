{
  # TODO: rework more declaratively
  tags = ["graphical"];
  module = {pkgs, ...}: let
    bibataIce = pkgs.runCommand "bibata-modern-ice" {} ''
      mkdir -p $out/share/icons
      cp -a ${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Ice $out/share/icons/
    '';
  in {
    environment.systemPackages = [
      pkgs.adw-gtk3

      #pkgs.dracula-icon-theme
      (pkgs.papirus-icon-theme.override {color = "yellow";})

      pkgs.gsettings-desktop-schemas
      bibataIce
      pkgs.nwg-look
      pkgs.xsettingsd
      pkgs.xrdb
    ];
    xdg.sounds.enable = true;
    xdg.icons.enable = true;
    environment.variables = {
      GTK_THEME = "adw-gtk3";
      XCURSOR_THEME = "Bibata-Modern-Ice";
      QT_QPA_PLATFORMTHEME = "qt5ct";
    };
  };
}
