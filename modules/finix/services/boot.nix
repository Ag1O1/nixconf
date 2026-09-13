{fm, ...}: {
  imports = [fm.limine];
  boot.loader.efi.canTouchEfiVariables = true;
  programs.limine = {
    enable = true;
    settings = {
      # UI
      interface_branding = "finix";
      interface_branding_colour = 5;
      interface_help_hidden = false;
      interface_resolution = "1920x1200";

      # Font
      #term_font = "boot():/EFI/limine/SCRWL---.F16";
      term_font_size = "8x16";
      term_font_scale = "2x2";
      term_font_spacing = 1;
      term_margin = 0;
      term_margin_gradient = 0;

      # Terminal colors
      term_palette = "1e1e2e;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;bac2de";
      term_palette_bright = "585b70;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4";
      term_foreground = "cdd6f4";
      term_foreground_bright = "cdd6f4";

      # Editor
      editor_enabled = true;
      editor_highlighting = true;
      editor_validation = true;
    };
  };
}
