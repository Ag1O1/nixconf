{
  config,
  lib,
  ...
}:
with lib;
let
  inherit (options) mkOption;
  inherit (types) str;
  inherit (config.modules.services.mime) browser;
in
{
  options.modules.services.mime = {
    enable = lib.mkEnableOption "mime";

    text = mkOption {
      type = str;
      default = "zed";
      description = "Defines text editor";
    };
    terminal = mkOption {
      type = str;
      default = "ghostty";
      description = "Defines terminal";
    };
    browser = mkOption {
      type = str;
      default = "firefox-developer-edition";
      description = "Defines browser";
    };
    pdf = mkOption {
      type = str;
      default = browser;
      description = "Defines pdf viewer";
    };
    image = mkOption {
      type = str;
      default = browser;
      description = "Defines image viewer";
    };
    video = mkOption {
      type = str;
      default = "vlc";
      description = "Defines video player";
    };
    audio = mkOption {
      type = str;
      default = video;
      description = "Defines audio player";
    };
    zip = mkOption {
      type = str;
      default = "ark";
      description = "Defines zip viewer";
    };
    svg = mkOption {
      type = str;
      default = "org.inkscape.Inkscape.desktop";
      description = "Defines svg editor";
    };
    file-manager = mkOption {
      type = str;
      default = "nautilus";
      description = "Defines file manager";
    };
  };
}
