{
  tags = ["graphical"];
  module = {
    pkgs,
    lib,
    ...
  }: let
    package = pkgs.evolutionWithPlugins;
  in {
    environment.systemPackages = [package];
    services.dbus.packages = [package];
  };
}
