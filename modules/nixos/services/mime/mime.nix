{config, ...}: let
  # Deconflict the namespace by pulling flake out of it
  inherit (config) flake;
in {
  flake.modules.nixos.mime = {
    config,
    lib,
    ...
  }: let
    inherit
      # These are nixos modules options and not a member of flake
      (config.modules.services.mime)
      text
      browser
      pdf
      image
      video
      audio
      svg
      zip
      file-manager
      ;

    defaultApplications = {
      "text/*" = "${text}.desktop";
      "inode/directory" = "${file-manager}";

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
  in {
    # This cames from the flake parts module
    imports = [flake.modules.nixos.mimeOptions];
    xdg.mime = {
      enable = true;
      inherit defaultApplications;
    };
    hj.files.".config/mimeapps.list".text = lib.generators.toINI {} {
      "Default Applications" = defaultApplications;
    };
  };
}
