{
  config,
  lib,
  ...
}:
with lib; let
  inherit (options) mkOption;
  inherit (types) str;
  inherit (config.modules.services.mime) browser;
in {
  options.modules.services.mime = {
    enable = lib.mkEnableOption "mime";

    text = mkOption {
      type = str;
      default = "Neovim";
      description = "Defines text editor";
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
    svg = mkOption {
      type = str;
      default = "inkscape";
      description = "Defines svg editor";
    };
  };
}
