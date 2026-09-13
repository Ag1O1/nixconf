{fm, ...}: {
  imports = [fm.limine];
  boot.loader.efi.canTouchEfiVariables = true;
  programs.limine = {
    enable = true;
    settings = {
      wallpaper = ./nixo.jpg;
      # UI
      interface_branding = "finix";
      interface_branding_colour = 7;
      interface_help_hidden = true;
      interface_resolution = "1920x1200";

      # Font
      term_font_size = "8x16";
      term_font_scale = "2x2";
      term_font_spacing = 1;
      term_margin = 80;
      term_margin_gradient = 0;

      # Terminal colors
      term_palette = "16181d;d16969;8fbf7f;d8a657;7daea3;d3869b;89b8c2;c5c8c6";
      term_palette_bright = "34373e;e68183;a8c98b;e5c07b;8ec07c;d3869b;8fbcbb;e6e9ef";

      term_foreground = "d6d9df";
      term_foreground_bright = "ffffff";

      # Editor
      editor_enabled = true;
      editor_highlighting = true;
      editor_validation = true;
    };
  };
}
