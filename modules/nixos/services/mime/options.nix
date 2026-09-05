{lib, ...}: {
  flake.modules.nixos.mimeOptions = {config, ...}: let
    # Don't `with lib`, instead selectively inherit
    inherit (lib.options) mkOption;
    inherit (lib.types) str;

    # This is in your nixos `config` and not the flake `config`
    inherit (config.modules.services.mime) browser video;
  in {
    options.modules.services.mime = {
      enable = lib.mkEnableOption "mime";

      text = mkOption {
        type = str;
        default = "nvim";
        description = "Defines text editor";
      };
      terminal = mkOption {
        type = str;
        default = "ghostty";
        description = "Defines terminal";
      };
      browser = mkOption {
        type = str;
        default = "qutebrowser";
        description = "Defines browser";
      };
      pdf = mkOption {
        type = str;
        default = "org.pwmt.zathura";
        description = "Defines pdf viewer";
      };
      image = mkOption {
        type = str;
        default = "qimgv";
        description = "Defines image viewer";
      };
      video = mkOption {
        type = str;
        default = "mpv";
        description = "Defines video player";
      };
      audio = mkOption {
        type = str;
        default = video;
        description = "Defines audio player";
      };
      zip = mkOption {
        type = str;
        default = "file-roller";
        description = "Defines zip viewer";
      };
      svg = mkOption {
        type = str;
        default = "org.inkscape.Inkscape.desktop";
        description = "Defines svg editor";
      };
      file-manager = mkOption {
        type = str;
        default = "nemo";
        description = "Defines file manager";
      };
    };
  };
}
