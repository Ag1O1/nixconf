{
  tags = ["graphical"];
  module = {cm, ...}: {
    imports = [cm.fastfetch];
    programs.fastfetch.enable = true;
    hj.xdg.config.files."fastfetch/config.jsonc".source = ./config.jsonc;
  };
}
