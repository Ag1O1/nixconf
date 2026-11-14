{
  tags = ["graphical"];
  module = {
    pkgs,
    config,
    ...
  }: let
    codeFont = config.custom.theming.fonts.code;
  in {
    hj.packages = [pkgs.kitty];
    hj.xdg.config.files."kitty/kitty.conf".text = ''
      font_family ${codeFont}
      font_size 14.0
      background_opacity 0.75
      include themes/noctalia.conf
    '';
  };
}
