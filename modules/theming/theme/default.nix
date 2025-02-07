# Theme settings heavily inspired by Lunarnovaa's config
# (this whole file is basically copied)
{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  inherit (lib.options) mkOption mkPackageOption;
  inherit (lib.types) attrs str int path;
in {
  options.theme = {
    colors = mkOption {
      type = attrs;
      #default = inputs.basix.schemeData.base24.catppuccin-mocha.palette;
      default = {
        base00 = "0F0E10"; #base
        base01 = "0e0e0e"; #mantle
        base02 = "3f3858"; #surface0
        base03 = "c6c7c7"; #surface1
        base04 = "dcdcde"; #surface2
        base05 = "f5f7f4"; #text
        base06 = "f5e0dc"; #rosewater
        base07 = "b7bdf8"; #lavender
        base08 = "F38BA8"; #light red
        base09 = "E69400"; #peach
        base0A = "EFB240"; #gold
        base0B = "57e05b"; #green
        base0C = "76B3F5"; #teal
        base0D = "4651F3"; #blue
        base0E = "8885EE"; #gold
        base0F = "AF4D1C"; #coffee
      };
      description = ''
        Defines a set of attributes for colors.
        Default is in base24 however any labeling and definitions will work.
      '';
    };
    cursor = {
      package = mkPackageOption pkgs ["bibata-cursors"];
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
        package = mkPackageOption pkgs ["cascadia-code"] {};
        name = mkOption {
          type = str;
          default = "CascadiaCode";
          description = "Defines the monospace font";
        };
      };

      sans = {
        package = mkPackageOption pkgs "inter" {};
        name = mkOption {
          type = str;
          default = "Inter";
          description = "Defines the sans font";
        };
      };

      serif = {
        package = mkPackageOption pkgs "roboto-serif" {};
        name = mkOption {
          type = str;
          default = "Roboto Serif";
          description = "Defines the serif font";
        };
      };

      emoji = {
        package = mkPackageOption pkgs "noto-fonts-color-emoji" {};
        name = mkOption {
          type = str;
          default = "Noto Color Emoji";
          description = "Defines the emoji font";
        };
      };

      cjk = {
        sans = {
          package = mkPackageOption pkgs "noto-fonts-cjk-sans" {};
          name = mkOption {
            type = str;
            default = "Noto Sans CJK SC";
            description = "Defines the CJK sans font";
          };
        };
        serif = {
          package = mkPackageOption pkgs "noto-fonts-cjk-serif" {};
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
