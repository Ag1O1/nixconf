# Theme settings heavily inspired by Lunarnovaa's config
# (this whole file is basically copied)
{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
let
  inherit (lib.options) mkOption mkPackageOption;
  inherit (lib.types)
    attrs
    str
    int
    path
    ;
in
{
  options.theme = {
    colors = mkOption {
      type = attrs;
      default = inputs.basix.schemeData.base24.catppuccin-mocha.palette;
      description = ''
        Defines a set of attributes for colors.
        Default is in base24 however any labeling and definitions will work.
      '';
    };
    cursor = {
      package = mkPackageOption pkgs [ "bibata-cursors" ];
      name = mkOption {
        type = str;
        default = "Bibata-Modern-Ice";
        description = "Defines cursor theme";
      };
      size = mkOption {
        type = int;
        default = 24;
        description = "Defines cursor size";
      };
    };

    fonts = {
      monospace = {
        package = mkPackageOption pkgs [ "cascadia-code" ] { };
        name = mkOption {
          type = str;
          default = "CascadiaCode";
          description = "Defines the monospace font";
        };
      };

      sans = {
        package = mkPackageOption pkgs "inter" { };
        name = mkOption {
          type = str;
          default = "Inter";
          description = "Defines the sans font";
        };
      };

      serif = {
        package = mkPackageOption pkgs "roboto-serif" { };
        name = mkOption {
          type = str;
          default = "Roboto Serif";
          description = "Defines the serif font";
        };
      };

      emoji = {
        package = mkPackageOption pkgs "noto-fonts-color-emoji" { };
        name = mkOption {
          type = str;
          default = "Noto Color Emoji";
          description = "Defines the emoji font";
        };
      };

      cjk = {
        sans = {
          package = mkPackageOption pkgs "noto-fonts-cjk-sans" { };
          name = mkOption {
            type = str;
            default = "Noto Sans CJK SC";
            description = "Defines the CJK sans font";
          };
        };
        serif = {
          package = mkPackageOption pkgs "noto-fonts-cjk-serif" { };
          name = mkOption {
            type = str;
            default = "Noto Serif CJK SC";
            description = "Defines the CJK serif font";
          };
        };
      };

      size = mkOption {
        type = int;
        default = 11;
        description = "Defines the font-size";
      };
    };
    wallpapers = {
      primary = mkOption {
        type = path;
        default = "${config.hj.directory}/Pictures/wallpapers/nix-dark-purple-compos-mediumcontrast4Kv2.png";
        description = "Defines the primary wallpaper";
      };
    };
  };
}
