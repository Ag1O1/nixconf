{
  tags = ["graphical"];
  module = {
    imports = [./_module.nix];
    programs.oo7.enable = true;
  };
}
