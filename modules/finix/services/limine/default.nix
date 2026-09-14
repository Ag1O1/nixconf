{fm, ...}: {
  imports = [fm.limine];
  boot.loader.efi.canTouchEfiVariables = true;
  programs.limine = {
    enable = true;
    settings = {
      interface_branding = "";
      interface_help_hidden = true;
      interface_resolution = "1920x1200";

      term_font = "boot():/EFI/limine/font.F16";
      term_font_size = "8x16";
      term_font_scale = "1x1";
      term_font_spacing = 1;
      term_margin = 80;
      term_margin_gradient = 0;

      term_foreground = "d6d9df";
      term_foreground_bright = "ffffff";

      wallpaper = [./wallpaper.jpg];
    };
    additionalFiles = {
      "EFI/limine/font.F16" = ./font.F16;
    };
  };
}
