{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.services.mime;

  inherit (config.modules.services.mime)
    text
    browser
    pdf
    image
    video
    svg
    ;
in
{
  imports = [ ./options.nix ];
  config = mkIf cfg.enable {
    xdg.mime = {
      enable = true;
      defaultApplications = {
        "text/*" = "${text}.desktop";

        "image/*" = "${image}.desktop";
        "video/*" = "${video}.desktop";
        "audio/*" = "${audio}.desktop";

        "x-scheme-handler/http" = "${browser}.desktop";
        "x-scheme-handler/https" = "${browser}.desktop";

        "application/zip" = "${zip}.desktop";
        "application/x-rar-compressed" = "${zip}.desktop";
        "application/x-7z-compressed" = "${zip}.desktop";
        "application/pdf" = "${pdf}.desktop";
        "application/x-blender" = "blender.desktop";
        "application/x-godot-project" = "org.godotengine.Godot4.desktop";
        "image/svg+xml" = "${svg}.desktop";
      };
    };
  };
}
