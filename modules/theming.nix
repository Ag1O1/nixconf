{
  tags = ["graphical"];
  module = {
    pkgs,
    lib,
    config,
    ...
  }: let
    cfg = config.custom.theming;
    inherit (lib.options) mkOption;
    inherit (lib.types) str int package submodule;
    bibataIce = pkgs.runCommand "bibata-modern-ice" {} ''
      mkdir -p $out/share/icons
      cp -a ${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Ice $out/share/icons/
    '';
  in {
    options.custom.theming = {
      cursor = mkOption {
        type = submodule {
          options = {
            name = mkOption {
              type = str;
              default = "Bibata-Modern-Ice";
              description = "Defines cursor name";
            };
            size = mkOption {
              type = int;
              default = 24;
              description = "Defines cursor size";
            };
            package = mkOption {
              type = package;
              default = bibataIce;
              description = "Defines cursor package";
            };
          };
        };
      };

      iconTheme = mkOption {
        type = submodule {
          options = {
            name = mkOption {
              type = str;
              default = "Papirus-Dark";
              description = "Defines cursor name";
            };
            package = mkOption {
              type = package;
              default = pkgs.papirus-icon-theme.override {color = "yellow";};
              description = "Defines cursor package";
            };
          };
        };
      };

      fonts = mkOption {
        type = submodule {
          options = {
            code = mkOption {
              type = str;
              default = "JetBrainsMono Nerd Font";
              description = "Defines the code font";
            };
            sansSerif = mkOption {
              type = str;
              default = "Roboto";
              description = "Defines the sansSerif font";
            };
          };
        };
      };
    };
    config = {
      environment.systemPackages = [
        pkgs.adw-gtk3
        cfg.iconTheme.package
        cfg.cursor.package

        pkgs.gsettings-desktop-schemas
        pkgs.nwg-look
        pkgs.xsettingsd
        pkgs.xrdb
      ];
      xdg.sounds.enable = true;
      xdg.icons.enable = true;
      environment.variables = {
        GTK_THEME = "adw-gtk3";
        QT_QPA_PLATFORMTHEME = "qt5ct";
        XCURSOR_THEME = cfg.cursor.name;
        XCURSOR_size = toString cfg.cursor.size;
      };
    };
  };
}
