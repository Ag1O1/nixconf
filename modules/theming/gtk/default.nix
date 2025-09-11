# copied from lunarnova
{
  config,
  pkgs,
  ...
}: let
  inherit (config.theme) fonts cursor;
  inherit (builtins) toString;

  gtk-theme-pkg = pkgs.tokyonight-gtk-theme;
  gtk-icon-pkg = pkgs.kanagawa-icon-theme;
  gtk-fallback-icon-pkg = pkgs.kdePackages.breeze-icons;

  gtk-theme-name = "Tokyonight-Dark";
  gtk-icon-name = "Papirus";
  gtk-fallback-icon-name = "breeze-dark";
  # I have no idea if this is correct.
  # Seems to me that the only difference between gtkrc and 3,4's settings is the [Settings] part.
  # I am not sure if that's actually the case.
  gtk2-settings = ''
    gtk-application-prefer-dark-theme = true
    gtk-cursor-theme-name = "${cursor.name}"
    gtk-cursor-theme-size = ${toString cursor.size}
    style "user-font"
    {
      font-name = "${fonts.sans.name} ${toString fonts.size}"
    }
    gtk-icon-theme-name = "${gtk-icon-name}""
    gtk-theme-name = "${gtk-theme-name}"'';
  gtk-settings = "[Settings]
gtk-application-prefer-dark-theme = true
gtk-cursor-theme-name = ${cursor.name}
gtk-cursor-theme-size = ${toString cursor.size}
gtk-font-name = ${fonts.sans.name} ${toString fonts.size}
gtk-fallback-icon-theme = ${gtk-fallback-icon-name}
gtk-icon-theme-name = ${gtk-icon-name}
gtk-theme-name = ${gtk-theme-name}";
in {
  environment.variables = {
    XCURSOR_THEME = cursor.name;
    XCURSOR_SIZE = cursor.size;
  };
  xdg.icons.fallbackCursorThemes = [cursor.name];
  hj = {
    # switched to using nwg-look instead
    /*
    files = {
      ".gtkrc-2.0".text = gtk2-settings;
      ".config/gtk-3.0/settings.ini".text = gtk-settings;
      ".config/gtk-4.0/settings.ini".text = gtk-settings;
      ".config/gtk-4.0/gtk.css".source =
        "${gtk-theme-pkg}/share/themes/${gtk-theme-name}/gtk-4.0/gtk-dark.css";
      ".config/gtk-3.0/gtk.css".source =
        "${gtk-theme-pkg}/share/themes/${gtk-theme-name}/gtk-3.0/gtk-dark.css";
      ".local/share/icons/${gtk-icon-name}".source = "${gtk-icon-pkg}/share/icons/${gtk-icon-name}";
      ".local/share/icons/${gtk-fallback-icon-name}".source =
        "${gtk-fallback-icon-pkg}/share/icons/${gtk-fallback-icon-name}";
    };
    */
    packages = [
      gtk-icon-pkg
      gtk-theme-pkg
      pkgs.bibata-cursors
      pkgs.xsettingsd
      pkgs.xorg.xrdb
    ];
  };

  environment.sessionVariables = {
    GTK2_RC_FILES = "${config.hj.directory}/.gtkrc-2.0";
    GTK_THEME = "${gtk-theme-name}";
  };
}
