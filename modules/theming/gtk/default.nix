# copied from lunarnova
{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (config.theme) fonts cursor;
  inherit (builtins) toString;

  gtk-theme-pkg = pkgs.catppuccin-gtk.override {
    accents = ["green"];
    variant = "mocha";
    size = "standard";
    tweaks = ["normal"];
  };
  gtk-theme-name = "catppuccin-mocha-green-standard+normal";
  # I have no idea if this is correct.
  # Seems to me that the only difference between gtkrc and 3,4's settings is the [Settings] part.
  # I am not sure if that's actually the case.
  gtk2-settings = "
    gtk-application-prefer-dark-theme=true
    gtk-button-images=1
    gtk-cursor-theme-name=${cursor.name}
    gtk-cursor-theme-size=${toString cursor.size}
    gtk-font-name = ${fonts.sans.name} ${toString fonts.size}
    gtk-decoration-layout=appmenu:none
    gtk-enable-event-sounds=0
    gtk-enable-input-feedback-sounds=0
    gtk-error-bell=0
    gtk-icon-theme-name=Papirus-Dark
    gtk-menu-images=1
    gtk-theme-name=${gtk-theme-name}
    gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
    gtk-toolbar-style=GTK_TOOLBAR_BOTH
    gtk-xft-antialias=1
    gtk-xft-hinting=1
    gtk-xft-hintstyle=hintslight
  ";
  gtk-settings = "
    [Settings]
    ${gtk2-settings}
  ";
in {
  hj = {
    files = {
      ".gtkrc-2.0".text = gtk2-settings;
      ".config/gtk-3.0/settings.ini".text = gtk-settings;
      ".config/gtk-4.0/settings.ini".text = gtk-settings;
      #"config/gtk-4.0/gtk.css".source = "${gtk-theme-pkg}/share/themes/${gtk-theme-name}/gtk-4.0/gtk-dark.css";
      "config/gtk-4.0/gtk.css".source = ./gtk.css;
    };
    packages = [
      (pkgs.catppuccin-papirus-folders.override {
        accent = "green";
        flavor = "mocha";
      })
      gtk-theme-pkg
    ];
  };

  environment.sessionVariables = {
    GTK2_RC_FILES = "${config.hj.directory}/.gtkrc-2.0";
    GTK_THEME = "${gtk-theme-name}";
  };
}
